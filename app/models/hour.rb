class Hour < ActiveRecord::Base

validates :start_schedule, :presence => true
validates :end_schedule, :presence => true

  def get_dow(dow)
    if dow == 1
      start_time = self.sunday_start
      end_time = self.sunday_end
    elsif dow == 2
      start_time = self.monday_start
      end_time = self.monday_end
    elsif dow == 3
      start_time = self.tuesday_start
      end_time = self.tuesday_end
    elsif dow == 4
      start_time = self.wednesday_start
      end_time = self.wednesday_end
    elsif dow == 5
      start_time = self.thursday_start
      end_time = self.thursday_end
    elsif dow == 6
      start_time = self.friday_start
      end_time = self.friday_end
    elsif dow == 7
      start_time = self.saturday_start
      end_time = self.saturday_end
    else
      return nil
    end

    ret = {}
    ret['start'] = start_time
    ret['end'] = end_time

    return ret
  end


  def print_dow(dow, fmt = "%I:%M %P")

    times = self.get_dow(dow)

    start_time = times['start']
    end_time = times['end']

    if start_time.blank? || end_time.blank?
      return 'Closed'
    end

    return start_time.strftime(fmt) + " to " + end_time.strftime(fmt)
  end

  def self.dow(dow)
    days_of_week = ['', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']

    if dow.between? 1, 7
      return days_of_week[dow]
    end

    return nil
  end


  def to_json
    json_hour = {}
    for i in 1..7 do
      times = self.get_dow(i)
      temp = {}

      if times['start'].blank?
        temp['open'] = nil
      else
        temp['open'] = times['start'].strftime("%H:%M")
      end

      if times['end'].blank?
        temp['close'] = nil
      else
        temp['close'] = times['end'].strftime("%H:%M")
      end


      json_hour[Hour.dow(i)] = temp
    end

    return json_hour

  end
end
