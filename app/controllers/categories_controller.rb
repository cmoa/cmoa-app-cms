class CategoriesController < ApplicationController
  before_action :set_exhibition
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  cache_sweeper :cache_sweeper, :only => [:create, :update, :destroy]
  before_action do
    set_focus(3)
  end

  def index
    @categories = Category.all.order('title asc')
  end

  def show
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to @category, notice: 'Category was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @category.update(category_params)
      redirect_to @category, notice: 'Category was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    # Check if this object related to any non-deleted objects
    unless @category.artworks.empty?
      return redirect_to categories_url, alert: "At least one artwork relies on this category – cannot delete '#{@category.title}'"
    end

    @category.destroy
    # Acts_as_paranoid bug workaround
    @category.updated_at = DateTime.now
    @category.save
    redirect_to categories_url, notice: 'Category was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:category).permit(:title)
    end
end
