class AlterBeaconUniqueKeys < ActiveRecord::Migration
  def change
    remove_column :beacons, :beacon_ident

    add_index :beacons, [:major, :minor], :unique => true
  end
end
