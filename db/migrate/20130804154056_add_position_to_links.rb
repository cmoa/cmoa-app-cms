class AddPositionToLinks < ActiveRecord::Migration
  def change
    add_column :links, :position, :integer, :default => 0, :null => false
  end
end