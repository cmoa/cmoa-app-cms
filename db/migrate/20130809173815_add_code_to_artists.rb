class AddCodeToArtists < ActiveRecord::Migration
  def change
    add_column :artists, :code, :string
  end
end