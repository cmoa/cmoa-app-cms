class Addnametobeacons < ActiveRecord::Migration
  def change
    add_column :beacons, :name, :string
  end
end
