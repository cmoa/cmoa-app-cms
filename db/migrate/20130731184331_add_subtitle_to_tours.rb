class AddSubtitleToTours < ActiveRecord::Migration
  def change
    add_column :tours, :subtitle, :string
  end
end