class AddSponsorToExhibitions < ActiveRecord::Migration
  def change
    add_column :exhibitions, :sponsor, :string
  end
end