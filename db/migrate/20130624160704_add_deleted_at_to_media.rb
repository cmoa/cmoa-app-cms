class AddDeletedAtToMedia < ActiveRecord::Migration
  def change
    add_column :media, :deleted_at, :datetime
  end
end