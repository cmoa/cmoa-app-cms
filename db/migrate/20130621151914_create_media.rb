class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.integer :exhibition_id
      t.integer :artwork_id
      t.string :kind

      t.timestamps
    end
  end
end
