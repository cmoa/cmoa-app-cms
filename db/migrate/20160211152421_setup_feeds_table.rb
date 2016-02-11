class SetupFeedsTable < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string    :name
      t.string    :url
      t.integer   :type
      t.timestamps
    end
  end
end
