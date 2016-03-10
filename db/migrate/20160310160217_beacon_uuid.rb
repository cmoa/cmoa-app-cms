class BeaconUuid < ActiveRecord::Migration
  def change
    add_column :beacons, :uuid, :string
  end
end
