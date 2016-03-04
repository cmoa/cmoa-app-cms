class ArtistArtworksController < ApplicationController
  before_action :set_exhibition
  before_action :set_artwork
  before_action :set_arist_artwork, only: [:edit, :update, :destroy]
  cache_sweeper :cache_sweeper, :only => [:create, :update, :destroy]
  before_action do
    set_focus('object')
  end

  def new
    @artist_artwork = ArtistArtwork.new
  end

  def edit
  end

  def create
    @artist_artwork = ArtistArtwork.new(artwork_params)

    # Set the artwork
    @artist_artwork.artwork = @artwork

    # Set the exhibition
    @artist_artwork.exhibition_id = @artwork.exhibition_id

    if @artist_artwork.save
      redirect_to [@exhibition, @artwork], notice: 'Artist was successfully added.'
    else
      render action: 'new'
    end
  end

  def update
    if @artist_artwork.update(artwork_params)
      redirect_to [@exhibition, @artwork], notice: 'a Person was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy

    @artist_artwork.destroy
    # Acts_as_paranoid bug workaround
    @artist_artwork.updated_at = DateTime.now
    @artist_artwork.save
    redirect_to [@exhibition, @artwork], notice: 'a Person was successfully removed.'
  end

  private
    def set_artwork
      @artwork = Artwork.find(params[:artwork_id])
    end

    def set_arist_artwork
      @artist_artwork = ArtistArtwork.find(params[:id])
    end

    def artwork_params
      params.require(:artist_artwork).permit(:artist_id)
    end
end
