class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :uuid
      t.integer :artist_id
      t.integer :exhibition_id
      t.string :title
      t.string :url
      t.datetime :deleted_at

      t.timestamps
    end
  end
end