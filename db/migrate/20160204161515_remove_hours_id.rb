class RemoveHoursId < ActiveRecord::Migration
  def change
    remove_column :hours, :hours_id, :integer
  end
end
