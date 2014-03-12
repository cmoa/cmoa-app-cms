class AddIsLiveToExhibitions < ActiveRecord::Migration
  def change
    add_column :exhibitions, :is_live, :boolean, :default => false
  end
end