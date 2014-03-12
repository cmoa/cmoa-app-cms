class AddPositionToTours < ActiveRecord::Migration
  def change
    add_column :tours, :position, :integer
  end
end