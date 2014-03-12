class CreateTourArtworks < ActiveRecord::Migration
  def change
    create_table :tour_artworks do |t|
      t.integer :tour_id
      t.integer :artwork_id
      t.integer :position
      t.timestamps
    end
  end
end