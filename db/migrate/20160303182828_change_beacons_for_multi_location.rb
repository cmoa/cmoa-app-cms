class ChangeBeaconsForMultiLocation < ActiveRecord::Migration
  def change
    #remove old indexes
    remove_column :artwork, :beacon_id, :integer
    remove_column :location, :beacon_id, :integer

    #add new indexes
    add_index :beacons, :artwork
    add_index :beacons, :locations

    #add timestamps
    add_column(:beacons, :created_at, :datetime)
    add_column(:beacons, :updated_at, :datetime)

  end
end
