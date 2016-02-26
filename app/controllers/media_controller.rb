class MediaController < ApplicationController
  before_action :set_exhibition
  before_action :set_artwork
  before_action :set_medium, only: [:show, :edit, :update, :destroy]
  cache_sweeper :cache_sweeper, :only => [:create, :update, :destroy, :positions]
  before_action do
    set_focus('objects')
  end
  
  def index
    @media = @artwork.media
  end

  def show
  end

  def new
    @medium = Medium.new
  end

  def edit
  end

  def create
    @medium = Medium.new(medium_params)

    # Set the exhibition
    @medium.exhibition_id = @exhibition.id

    # Set artwork relation
    @medium.artwork = @artwork

    # Calculate the position
    position = @artwork.media.where(:kind => @medium.kind).maximum('position')
    if position.nil?
      position = 0
    else
      position += 1
    end
    @medium.position = position

    if @medium.save
      redirect_to [@exhibition, @artwork], notice: 'Medium was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @medium.update(medium_params)
      redirect_to [@exhibition, @artwork], notice: 'Medium was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    # Acts_as_paranoid bug workaround
    @medium.updated_at = DateTime.now
    @medium.save
    @medium.destroy
    redirect_to [@exhibition, @artwork], notice: 'Medium was successfully deleted.'
  end

  def positions
    # Vars
    positions = params[:positions]
    kind = params[:kind]
    return render :json => {:success => false, :msg => 'Wrong parameters'} if (positions.nil? || kind.nil?)

    # Parse position
    positions = positions.split(',')
    positions.each_with_index do |id, index|
      medium = @artwork.media.where(:kind => kind).find(id.to_i)
      next if medium.nil?
      medium.position = index
      medium.save
    end

    render :json => {:success => true}
  end

  private
    def set_artwork
      @artwork = Artwork.find(params[:artwork_id])
    end

    def set_medium
      @medium = Medium.find(params[:id])
    end

    def medium_params
      params.require(:medium).permit(:title, :file)
    end
end
