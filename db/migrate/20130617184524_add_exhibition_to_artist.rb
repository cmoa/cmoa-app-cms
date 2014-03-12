class AddExhibitionToArtist < ActiveRecord::Migration
  def change
    add_column :artists, :exhibition_id, :integer
  end
end