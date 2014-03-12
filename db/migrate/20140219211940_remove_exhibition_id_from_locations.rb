class RemoveExhibitionIdFromLocations < ActiveRecord::Migration
  def change
    remove_column :locations, :exhibition_id
  end
end