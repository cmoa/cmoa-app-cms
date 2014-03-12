class AddUuidToTourArtworks < ActiveRecord::Migration
  def change
    add_column :tour_artworks, :uuid, :string, :null => false
  end
end