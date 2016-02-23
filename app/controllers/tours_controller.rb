class ToursController < ApplicationController
  before_action :set_exhibition
  before_action :set_tour, only: [:show, :edit, :update, :destroy]
  cache_sweeper :cache_sweeper, :only => [:create, :update, :destroy]
  before_action do
    set_focus('tours')
  end

  def index
    @tours = @exhibition.tours
  end

  def show
  end

  def new
    @tour = Tour.new
  end

  def edit
  end

  def create
    @tour = Tour.new(tour_params)

    # Set the exhibition
    @tour.exhibition_id = @exhibition.id

    if @tour.save
      redirect_to [@exhibition, @tour], notice: 'Tour was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @tour.update(tour_params)
      redirect_to [@exhibition, @tour], notice: 'Tour was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @tour.destroy
    # Acts_as_paranoid bug workaround
    @tour.updated_at = DateTime.now
    @tour.save
    redirect_to exhibition_tours_url(@exhibition)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tour
      @tour = Tour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tour_params
      params.require(:tour).permit(:exhibition_id, :title, :subtitle, :body)
    end
end
