class RemoveHoursId < ActiveRecord::Migration
  def change
    remove_column :hous, :hours_id, :integer
  end
end
