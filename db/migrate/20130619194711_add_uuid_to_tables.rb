class AddUuidToTables < ActiveRecord::Migration
  def change
    add_column :artists, :uuid, :string, :null => false
    add_column :artworks, :uuid, :string, :null => false
    add_column :categories, :uuid, :string, :null => false
    add_column :exhibitions, :uuid, :string, :null => false
    add_column :tours, :uuid, :string, :null => false
  end
end