class RenameBeaconsId < ActiveRecord::Migration
  def change
    remove_column :artworks, :beacons_id
    remove_column :locations, :beacons_id

    add_reference :artworks, :beacon, index: true
    add_reference :locations, :beacon, index: true
  end
end
