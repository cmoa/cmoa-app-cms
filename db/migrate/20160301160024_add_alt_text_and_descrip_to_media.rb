class AddAltTextAndDescripToMedia < ActiveRecord::Migration
  def change
    add_column :media, :alt, :string
    add_column :media, :description, :text
  end
end
