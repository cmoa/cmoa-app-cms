class AddExhibitionIdToTourArtworks < ActiveRecord::Migration
  def change
    add_column :tour_artworks, :exhibition_id, :integer
  end
end