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
    @beacon = Beacon.new
    render action: 'new'
  end

  def edit
  end

  def update
  end

  def delete
  end
end
