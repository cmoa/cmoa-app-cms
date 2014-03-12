class CreateArtworks < ActiveRecord::Migration
  def change
    create_table :artworks do |t|
      t.integer :exhibition_id
      t.integer :artist_id
      t.string :title
      t.string :subtitle
      t.string :code
      t.text :body

      t.timestamps
    end
  end
end
