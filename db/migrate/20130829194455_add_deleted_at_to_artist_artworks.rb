class AddDeletedAtToArtistArtworks < ActiveRecord::Migration
  def change
    add_column :artist_artworks, :deleted_at, :datetime
  end
end