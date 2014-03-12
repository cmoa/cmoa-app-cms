namespace :cache do
  desc 'Generate likes cache'
  task :generateLikes => :environment do
    # API v1
    # ------------------------------
    # Get all likes
    likeHash = {}
    Like.where(:exhibition_id => DEFAULT_EXHIBITION_ID).count(:group => 'artwork_id').each do |artwork_id, total|
      # Find artwork
      artwork = Artwork.find(artwork_id)
      next if artwork.nil? # If deleted

      likeHash[artwork.uuid] = total
    end

    # Update redis
    $redis.mapped_hmset('v1:likes', likeHash) unless likeHash.keys.empty?
    puts 'Done (v1)'

    # API v2
    # ------------------------------
    # Get all likes
    likeHash = {}
    Like.count(:group => 'artwork_id').each do |artwork_id, total|
      # Find artwork
      artwork = Artwork.find(artwork_id)
      next if artwork.nil? # If deleted

      likeHash[artwork.uuid] = total
    end

    # Update redis
    $redis.mapped_hmset('v2:likes', likeHash) unless likeHash.keys.empty?
    puts 'Done (v2)'
  end
end