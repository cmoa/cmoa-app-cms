class DropNameFromArtists < ActiveRecord::Migration
  def change
    remove_column :artists, :name
  end
end