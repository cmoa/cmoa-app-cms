class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :exhibition_id
      t.string :name
      t.string :uuid, :null => false
      t.timestamps
    end
  end
end
