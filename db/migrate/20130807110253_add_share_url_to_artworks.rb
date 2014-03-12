class AddShareUrlToArtworks < ActiveRecord::Migration
  def change
    add_column :artworks, :share_url, :string
  end
end