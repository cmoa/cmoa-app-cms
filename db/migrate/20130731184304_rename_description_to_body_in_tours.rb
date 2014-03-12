class RenameDescriptionToBodyInTours < ActiveRecord::Migration
  def change
    rename_column :tours, :description, :body
  end
end