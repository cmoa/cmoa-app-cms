class BeaconsController < ApplicationController
  before_action :set_exhibition
  before_action :set_beacon, only: [:show, :edit, :update, :destroy]


  def index
    @beacons = Beacon.all
  end

  def show
  end

  def new
    @beacon = Beacon.new
  end

  def create
    @beacon = Beacon.new(beacon_params)

    if @beacon.save
      redirect_to @beacon, notice: 'Beacon was successfully created.'
    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
    if @beacon.update(beacon_params)
      redirect_to @beacon, notice: 'Beacon was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @beacon.destroy

    redirect_to @beacon, notice: 'Beacon was successfully deleted.'
  end

  def detach
    @beacon= Beacon.find(params[:beacon_id])
    @beacon.detach
    render action: 'index', notice: 'Beacon was successfully detached.'
  end

private
  def beacon_params
      params.require(:beacon).permit(:major, :minor, :name)
  end
  def set_beacon
    @beacon= Beacon.find(params[:id])
  end
end
