class CreateExhibitions < ActiveRecord::Migration
  def change
    create_table :exhibitions do |t|
      t.string :title
      t.string :subtitle
      t.timestamps
    end
  end
end