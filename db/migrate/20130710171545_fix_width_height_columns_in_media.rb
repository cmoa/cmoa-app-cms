class FixWidthHeightColumnsInMedia < ActiveRecord::Migration
  def change
    rename_column :media, :image_width, :width
    rename_column :media, :image_height, :height
  end
end