class ArtistsController < ApplicationController
  before_action :set_exhibition
  before_action :set_artist, only: [:show, :edit, :update, :destroy]
  cache_sweeper :cache_sweeper, :only => [:create, :update, :destroy]
  before_action do
    set_focus('people')
  end

  def index
    @artists = @exhibition.artists
  end

  def show
  end

  def new
    @artist = Artist.new
  end

  def edit
  end

  def create
    @artist = Artist.new(artist_params)

    # Set the exhibition
    @artist.exhibition_id = @exhibition.id

    if @artist.save
      redirect_to [@exhibition, @artist], notice: 'Artist was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @artist.update(artist_params)
      redirect_to [@exhibition, @artist], notice: 'Artist was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    # Check if this object related to any non-deleted objects
    unless @artist.artworks.empty?
      return redirect_to exhibition_artists_url(@exhibition), alert: "At least one artwork relies on this artist – cannot delete '#{@artist.name}'"
    end

    @artist.destroy
    # Acts_as_paranoid bug workaround
    @artist.updated_at = DateTime.now
    @artist.save
    redirect_to exhibition_artists_url(@exhibition)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artist
      @artist = Artist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def artist_params
      params.require(:artist).permit(:first_name, :last_name, :country, :bio, :code)
    end
end
