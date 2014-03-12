class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :exhibition_id
      t.integer :artwork_id
      t.string :device
      t.timestamps
    end
  end
end