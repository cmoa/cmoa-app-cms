class AddUuidToMedia < ActiveRecord::Migration
  def change
    add_column :media, :uuid, :string, :null => false
  end
end