class AddExhibitionIdToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :exhibition_id, :integer
  end
end