class RemoveExhibitionIdFromCategories < ActiveRecord::Migration
  def change
    remove_column :categories, :exhibition_id
  end
end