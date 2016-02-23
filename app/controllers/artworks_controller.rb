class ArtworksController < ApplicationController
  before_action :set_exhibition
  before_action :set_artwork, only: [:show, :edit, :update, :destroy]
  cache_sweeper :cache_sweeper, :only => [:create, :update, :destroy]
  before_action do
    set_focus(5)
  end

  def index
    # Filters
    @filter_artist = params[:filter_artist]
    @filter_category = params[:filter_category]
    @filter_location = params[:filter_location]
    @is_filtering = !(@filter_artist.nil? && @filter_category.nil? && @filter_location.nil?)

    # Find artworks
    @artworks = @exhibition.artworks.order('title asc')
    unless @filter_artist.nil?
      @artworks = @artworks.joins(:artist_artworks).uniq.where(artist_artworks: {artist_id: @filter_artist})
    end
    unless @filter_category.nil?
      @artworks = @artworks.where(:category_id => @filter_category)
    end
    unless @filter_location.nil?
      @artworks = @artworks.where(:location_id => @filter_location)
    end
  end

  def show
  end

  def new
    # Artist check
    if @exhibition.artists.count == 0
      return redirect_to exhibition_artworks_path(@exhibition), alert: 'Please add at least one artist before adding artwork.'
    end
    # Category check
    if Category.count == 0
      return redirect_to categories_path, alert: 'Please add at least one category before adding artwork.'
    end
    # Location check
    if Location.count == 0
      return redirect_to locations_path, alert: 'Please add at least one location before adding artwork.'
    end
    @artwork = Artwork.new
  end

  def edit

  end

  def create

    # Verity artistArtwork relation
    if artwork_params[:artist_id].nil?
      flash.now[:notice] = 'Please specify an artist for this artwork'
      render action: 'new'
      return
    end

    @artwork = Artwork.new(artwork_params)

    # Set the exhibition
    @artwork.exhibition_id = @exhibition.id

    if @artwork.save
      # Create artistArtwork relation
      aa = ArtistArtwork.new
      aa.exhibition_id = @artwork.exhibition_id
      aa.artwork = @artwork
      aa.artist_id = artwork_params[:artist_id]
      aa.save

      redirect_to [@exhibition, @artwork], notice: 'Artwork was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @artwork.update(artwork_params)
      redirect_to [@exhibition, @artwork], notice: 'Artwork was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    # Delete all artistArtwork relations
    @artwork.artist_artworks.destroy_all
    # Acts_as_paranoid bug workaround
    @artwork.artist_artworks.with_deleted.each do |artistArtwork|
      artistArtwork.updated_at = DateTime.now
      artistArtwork.save
    end

    # Delete actual artwork
    @artwork.destroy
    # Acts_as_paranoid bug workaround
    @artwork.updated_at = DateTime.now
    @artwork.save
    redirect_to exhibition_artworks_url(@exhibition)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artwork
      @artwork = Artwork.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def artwork_params
      params.require(:artwork).permit(:title, :artist_id, :category_id, :location_id, :code, :body, :beacon_id, :share_url)
    end
end
