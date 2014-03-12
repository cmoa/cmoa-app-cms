class AddExhibitionIdToArtistArtworks < ActiveRecord::Migration
  def change
    add_column :artist_artworks, :exhibition_id, :integer
  end
end