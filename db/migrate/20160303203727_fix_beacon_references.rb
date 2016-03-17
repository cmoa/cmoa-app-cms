class FixBeaconReferences < ActiveRecord::Migration
  def change
    #Remove incrorrect columns
    remove_column :beacons, :locations_id, :integer
    remove_column :beacons, :artworks_id, :integer

    #Add correct references
    add_reference :beacons, :artwork, index: true
    add_reference :beacons, :location, index: true
  end
end
