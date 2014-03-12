class AddFilesToExhibitions < ActiveRecord::Migration
  def change
    add_attachment :exhibitions, :bg_iphone
    add_attachment :exhibitions, :bg_ipad
  end
end