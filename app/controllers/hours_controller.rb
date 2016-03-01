class HoursController < ApplicationController
  before_action :set_exhibition
  before_action :set_hour, only: [:show, :edit, :update, :destroy]
  before_action do
    set_focus('hours')
  end

  def index
    @hours = Hour.all
  end

  def show

  end

  def new
    @hour = Hour.new
  end

  def edit
  end

  def update
    if @hour.update(hour_params)
      redirect_to @hour, notice: 'Schedule was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def create
    @hour = Hour.new(hour_params)

    if @hour.save
      redirect_to @hour, notice: 'Schedule was successfully created.'
    else
      render action: 'new'
    end
  end

  def destroy
    @hour.destroy
    redirect_to action: :index
  end





    def hour_params
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

    private
      def set_hour
        @hour = Hour.find(params[:id])
      end
end
