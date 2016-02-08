class ExhibitionsController < ApplicationController
  before_action :set_exhibition, only: [:show, :edit, :update, :destroy]
  cache_sweeper :cache_sweeper, :only => [:create, :update, :destroy, :positions]

  def index
    unset_exhibition
    @exhibitions = Exhibition.order('position asc').all
  end

  def show
    @total_artists = @exhibition.artists.size
    @total_categories = Category.all.size
    @total_artwork = @exhibition.artworks.size
    @total_locations = Location.all.size
    @total_tours = @exhibition.tours.size
  end

  def new
    @exhibition = Exhibition.new
  end

  def edit
  end

  def create
    @exhibition = Exhibition.new(exhibition_params)

    # Calculate the position
    position = Exhibition.maximum('position')
    if position.nil?
      position = 0
    else
      position += 1
    end
    @exhibition.position = position

    if @exhibition.save
      redirect_to @exhibition, notice: 'Exhibition was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @exhibition.update(exhibition_params)
      redirect_to root_path, notice: 'Exhibition was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    # Delete actual exhibition
    @exhibition.destroy
    # Acts_as_paranoid bug workaround
    @exhibition.updated_at = DateTime.now
    @exhibition.save
    redirect_to root_path
  end

  def positions
    # Vars
    positions = params[:positions]
    return render :json => {:success => false, :msg => 'Wrong parameters'} if positions.nil?

    # Parse position
    positions = positions.split(',')
    positions.each_with_index do |id, index|
      exhibition = Exhibition.find(id.to_i)
      next if exhibition.nil?
      exhibition.position = index
      exhibition.save
    end

    render :json => {:success => true}
  end

  private def set_exhibition
    if params.has_key?(:id)
      @exhibition = Exhibition.find(params[:id])
      session[:exhibition] = params[:id]
    else
      if session.has_key?(:exhibition)
        @exhibition = Exhibition.find(session[:exhibition])
      else
        @exhibition = nil #There isn't an exhibition
      end
      ###
    end
  end

    def exhibition_params
      params.require(:exhibition).permit(:title, :subtitle, :sponsor, :is_live, :bg_iphone, :bg_ipad)
    end
end
