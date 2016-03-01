class AddBeaconTable < ActiveRecord::Migration
  def change
    create_table :beacons do |t|
      t.integer :major, null: false
      t.integer :minor, null: false
      t.string :beacon_ident, null: false
    end
    add_index :beacons, :beacon_ident, :unique => true

    add_reference :artworks, :beacons, index: true
    add_reference :locations, :beacons, index: true
  end
end
