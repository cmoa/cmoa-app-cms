class CreateTours < ActiveRecord::Migration
  def change
    create_table :tours do |t|
      t.integer :exhibition_id
      t.string :title
      t.text :description
      t.timestamps
    end
  end
end