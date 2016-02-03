class HoursController < ApplicationController


  def index

  end

  def show

  end

  def new

  end

  def edit
  end

  def create

  end

  def destroy

  end





    def hours_params
      params.require(:hour).permit(
            :start_schedule,
            :end_schedule,
            :sunday_start,
            :sunday_end,
            :monday_start,
            :monday_end,
            :tuesday_start,
            :tuesday_end,
            :wednesday_start,
            :wednesday_end,
            :thursday_start,
            :thursday_end,
            :friday_start,
            :friday_end,
            :saturday_start,
            :saturday_end
          )


    end
end
