class ApiV2Controller < ApplicationController
  skip_before_filter :authenticate_admin!
  before_filter :check_params, :except => [:sync, :hours]
  protect_from_forgery :except => [:sync, :like, :subscribe, :hours]

  def sync
    since = Date.new(2011, 1, 1)
    ignoreDeleted = true

    # Date passed in?
    if (!params[:since].nil? && params[:since] != '')
      since = params[:since].to_datetime
      ignoreDeleted = false
    end

    # Check cache first
    cacheKey = 'v2:sync:' + since.to_time.to_i.to_s
    cachedResponse = $redis.get(cacheKey)

    unless cachedResponse.nil?
      response = JSON.parse(cachedResponse)
    else
      # Get fresh data from DB
      if ignoreDeleted
        artists = Artist.where('date_trunc(\'second\', artists.updated_at) > ?', since)
        artist_artworks = ArtistArtwork.where('date_trunc(\'second\', artist_artworks.updated_at) > ?', since)
        artwork = Artwork.where('date_trunc(\'second\', artworks.updated_at) > ?', since)
        categories = Category.where('date_trunc(\'second\', categories.updated_at) > ?', since)
        locations = Location.where('date_trunc(\'second\', locations.updated_at) > ?', since)
        links = Link.where('date_trunc(\'second\', links.updated_at) > ?', since)
        exhibitions = Exhibition.where('date_trunc(\'second\', exhibitions.updated_at) > ?', since)
        media = Medium.where('date_trunc(\'second\', media.updated_at) > ?', since)
        tours = Tour.where('date_trunc(\'second\', tours.updated_at) > ?', since)
        tour_artworks = TourArtwork.where('date_trunc(\'second\', tour_artworks.updated_at) > ?', since)
      else
        artists = Artist.where('date_trunc(\'second\', artists.updated_at) > ?', since).with_deleted
        artist_artworks = ArtistArtwork.where('date_trunc(\'second\', artist_artworks.updated_at) > ?', since).with_deleted
        artwork = Artwork.where('date_trunc(\'second\', artworks.updated_at) > ?', since).with_deleted
        categories = Category.where('date_trunc(\'second\', categories.updated_at) > ?', since).with_deleted
        locations = Location.where('date_trunc(\'second\', locations.updated_at) > ?', since).with_deleted
        links = Link.where('date_trunc(\'second\', links.updated_at) > ?', since).with_deleted
        exhibitions = Exhibition.where('date_trunc(\'second\', exhibitions.updated_at) > ?', since).with_deleted
        media = Medium.where('date_trunc(\'second\', media.updated_at) > ?', since).with_deleted
        tours = Tour.where('date_trunc(\'second\', tours.updated_at) > ?', since).with_deleted
        tour_artworks = TourArtwork.where('date_trunc(\'second\', tour_artworks.updated_at) > ?', since).with_deleted
      end

      # Prepare response
      response = {
        :status            => true,
        :artists           => artists,
        :artwork           => artwork,
        :artistArtworks    => artist_artworks,
        :categories        => categories,
        :locations         => locations,
        :links             => links,
        :exhibitions       => exhibitions,
        :media             => media,
        :tours             => tours,
        :tourArtworks      => tour_artworks
      }

      # Store in redis
      $redis.set(cacheKey, JSON.generate(response))
      $redis.rpush('sync:keys', cacheKey)
    end

    # Gather likes
    likes = $redis.hgetall('v2:likes')
    likes.each{|k,v| likes[k] = v.to_i} # Convert counts from string to int
    response[:likes] = likes

    # Configure gzipped response
    request.env['HTTP_ACCEPT_ENCODING'] = 'gzip'

    # Return
    return render :json => response
  end

  def hours
    #Vars
    s_date = params[:date]

    #Convert to date
    if s_date.blank?
      s_date = DateTime.now.to_date
    else
      s_date = Date.parse(s_date)
    end

    date_diff = "@(end_schedule::timestamp - start_schedule::timestamp)"

    #get the valid schedule
    @sch = Hour.where(s_date.strftime("%F")  + " BETWEEN start_schedule AND end_schedule").order(date_diff + " desc").limit(1)

    json = @sch.to_json

    # Configure gzipped response
    request.env['HTTP_ACCEPT_ENCODING'] = 'gzip'

    return render :json => json
  end

  def like
    # Vars
    artwork_uuid = params[:artwork]
    device_uuid = params[:device]

    # Verify
    return render :json => {:status => false} if artwork_uuid.nil? || device_uuid.nil?

    # Find artwork
    artwork = Artwork.find_by_uuid(artwork_uuid)
    return render :json => {:status => false} if artwork.nil?

    # Save the like
    like = Like.new
    like.exhibition_id = artwork.exhibition_id
    like.artwork = artwork
    like.device = device_uuid

    return render :json => {:status => true} if like.save
    return render :json => {:status => false}
  end

  def subscribe
    # Vars
    email = params[:email]

    # Verify
    return render :json => {:status => false} if email.nil?

    # Subscribe to a Mailchimp list
    Gibbon::API.lists.subscribe({
      :id => ENV['mailchimp_id'],
      :email => {:email => email},
      :double_optin => true,
      :send_welcome => true
    })

    return render :json => {:status => true}
  end

  private
  def check_params
    # Get required params
    token = request.headers['Token']
    signature1 = request.headers['Authorization']
    sodium = request.headers['Sodium']

    # Validate params
    if ((token.nil? || token.empty?) ||
        (signature1.nil? || signature1.empty?) ||
        (sodium.nil? || sodium.empty?))
      return render :json => {:status => false, :message => 'Invalid login'}
    end

    # Verify the token
    return render :json => {:status => false, :message => 'Invalid login'} if token != API_TOKEN

    # Build hashable string
    hashable = "#{request.method}:#{request.protocol}#{request.host}#{request.fullpath.split('?').first}?"
    filtered = ['action', 'controller', 'checksum', 'photo']
    # sorted = params.sort # This uses both GET & POST params
    sorted = request.GET.sort # This only uses the GET params
    params_string = ""
    sorted.each do |key, val|
      unless (filtered.include? key)
        params_string = "#{params_string}#{key}=#{CGI.escape(val)}&"
      end
    end

    hashable = "#{hashable}#{params_string}:#{API_SECRET}"

    # Generate signature and compare
    digest = OpenSSL::Digest::Digest.new('sha256')
    signature2 = Base64.strict_encode64(OpenSSL::HMAC.digest(digest, sodium, hashable))
    return render :json => {:status => false, :message => "Invalid Login"} if signature1 != signature2
  end
end
