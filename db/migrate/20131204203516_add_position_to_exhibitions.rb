class AddPositionToExhibitions < ActiveRecord::Migration
  def change
    add_column :exhibitions, :position, :integer
  end
end