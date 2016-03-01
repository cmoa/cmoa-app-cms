class LinksController < ApplicationController
  before_action :set_exhibition
  before_action :set_artist
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  cache_sweeper :cache_sweeper, :only => [:create, :update, :destroy]
  before_action do
    set_focus('people')
  end
  
  def index
    @links = @artist.links
  end

  def show
  end

  def new
    @link = Link.new
  end

  def edit
  end

  def create
    @link = Link.new(link_params)

    # Set the exhibition
    @link.exhibition_id = @exhibition.id

    # Set artist relation
    @link.artist = @artist

    # Calculate the position
    position = @artist.links.maximum('position')
    if position.nil?
      position = 0
    else
      position += 1
    end
    @link.position = position

    if @link.save
      redirect_to [@exhibition, @artist], notice: 'Link was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @link.update(link_params)
      redirect_to [@exhibition, @artist], notice: 'Link was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @link.destroy
    # Acts_as_paranoid bug workaround
    @link.updated_at = DateTime.now
    @link.save
    redirect_to [@exhibition, @artist], notice: 'Link was successfully deleted.'
  end

  def positions
    # Vars
    positions = params[:positions]
    return render :json => {:success => false, :msg => 'Wrong parameters'} if positions.nil?

    # Parse position
    positions = positions.split(',')
    positions.each_with_index do |id, index|
      link = @artist.links.find(id.to_i)
      next if link.nil?
      link.position = index
      link.save
    end

    render :json => {:success => true}
  end

  private
    def set_artist
      @artist = Artist.find(params[:artist_id])
    end

    def set_link
      @link = Link.find(params[:id])
    end

    def link_params
      params.require(:link).permit(:title, :url)
    end
end
