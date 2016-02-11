class AddBeaconIDs < ActiveRecord::Migration
  def change
    add_column :artworks, :beacon_major, :integer
    add_column :artworks, :beacon_minor, :integer
  end
end
