class BeaconsController < ApplicationController
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

  def beacon_params
      params.require(:beacon).premit(:major, :minor)
  end
end
