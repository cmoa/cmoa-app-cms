class CreateHoursTable < ActiveRecord::Migration
  def change
    create_table "hours", force: true do |t|
      t.integer   "hours_id"
      t.datetime  "start_schedule"
      t.datetime  "end_schedule"

      t.time      "sunday_start"
      t.time      "sunday_end"
      t.binary    "sunday_isopen"

      t.time      "monday_start"
      t.time      "monday_end"
      t.binary    "monday_isopen"

      t.time      "tuesday_start"
      t.time      "tuesday_end"
      t.binary    "tuesday_isopen"

      t.time      "wednesday_start"
      t.time      "wednesday_end"
      t.binary    "wednesday_isopen"

      t.time      "thursday_start"
      t.time      "thursday_end"
      t.binary    "thursday_isopen"

      t.time      "friday_start"
      t.time      "friday_end"
      t.binary    "friday_isopen"

      t.time      "saturday_start"
      t.time      "saturday_end"
      t.binary    "saturday_isopen"

      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
