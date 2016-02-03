class RemoveIsOpenColumns < ActiveRecord::Migration
  def change
    remove_column :hours, :monday_isopen
    remove_column :hours, :tuesday_isopen
    remove_column :hours, :wednesday_isopen
    remove_column :hours, :thursday_isopen
    remove_column :hours, :friday_isopen
    remove_column :hours, :saturday_isopen
    remove_column :hours, :sunday_isopen
  end
end
