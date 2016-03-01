class RemoveIsOpenColumns < ActiveRecord::Migration
  def change

        remove_column :hours, :monday_isopen, :binary
        remove_column :hours, :tuesday_isopen, :binary
        remove_column :hours, :wednesday_isopen, :binary
        remove_column :hours, :thursday_isopen, :binary
        remove_column :hours, :friday_isopen, :binary
        remove_column :hours, :saturday_isopen, :binary
        remove_column :hours, :sunday_isopen, :binary

  end
end
