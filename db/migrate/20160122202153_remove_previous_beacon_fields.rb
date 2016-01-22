class RemovePreviousBeaconFields < ActiveRecord::Migration
  def change
    remove_column :locations, :beacon_major
    remove_column :locations, :beacon_minor
    remove_column :artworks, :beacon_major
    remove_column :artworks, :beacon_minor
  end
end
