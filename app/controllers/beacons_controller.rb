class BeaconsController < ApplicationController

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
  end

  def delete
  end

private
  def beacon_params
      params.require(:beacon).permit(:major, :minor, :name)
  end
  def set_beacon
    @beacon= Beacon.find(params[:id])
  end
end
