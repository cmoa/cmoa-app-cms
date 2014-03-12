class AddDimensionsToMedia < ActiveRecord::Migration
  def change
    add_column :media, :image_width, :integer
    add_column :media, :image_height, :integer
  end
end