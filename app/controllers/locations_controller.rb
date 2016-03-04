class LocationsController < ApplicationController
  before_action :set_exhibition
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  cache_sweeper :cache_sweeper, :only => [:create, :update, :destroy]
  before_action do
    set_focus('locations')
  end

  def index
    @locations = Location.all.order('name asc')
  end

  def show
  end

  def new
    @location = Location.new
  end

  def edit
  end

  def create
    @location = Location.new(location_params)

    if @location.save
      redirect_to @location, notice: 'Location was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    beacons = params[:beacons]
    cause_an_error
    if @location.update(location_params)

      redirect_to @location, notice: 'Location was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    # Check if this object related to any non-deleted objects
    unless @location.artworks.empty?
      return redirect_to locations_url, alert: "At least one artwork relies on this location – cannot delete '#{@location.name}'"
    end

    @location.destroy
    # Acts_as_paranoid bug workaround
    @location.updated_at = DateTime.now
    @location.save
    redirect_to locations_url, notice: 'Location was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def location_params
      params.require(:location).permit(:name, :beacon_id)
    end
end
