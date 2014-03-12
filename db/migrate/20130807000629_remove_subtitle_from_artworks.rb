class RemoveSubtitleFromArtworks < ActiveRecord::Migration
  def change
    remove_column :artworks, :subtitle
  end
end