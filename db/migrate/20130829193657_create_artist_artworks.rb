class CreateArtistArtworks < ActiveRecord::Migration
  def change
    create_table :artist_artworks do |t|
      t.string :uuid
      t.integer :artist_id
      t.integer :artwork_id
      t.timestamps
    end
  end
end