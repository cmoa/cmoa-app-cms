class AddDeletedAtToModels < ActiveRecord::Migration
  def change
    add_column :artists, :deleted_at, :datetime
    add_column :artworks, :deleted_at, :datetime
    add_column :categories, :deleted_at, :datetime
    add_column :exhibitions, :deleted_at, :datetime
    add_column :tours, :deleted_at, :datetime
    add_column :tour_artworks, :deleted_at, :datetime
  end
end