class AddBeaconIDsToLocations < ActiveRecord::Migration

    def change
      add_column :locations, :beacon_major, :integer
      add_column :locations, :beacon_minor, :integer
    end

end
