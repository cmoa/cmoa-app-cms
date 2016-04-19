class FeedsController < ApplicationController
  before_action :set_exhibition
  before_action :set_feed, only: [:show, :edit, :update, :destroy]
  before_action do
    set_focus('feeds')
  end

  def index
    @feeds = Feed.all
  end

  def new
    @feed = Feed.new
  end

  def create
    @feed = Feed.new(feed_params)
    if @feed.save
      redirect_to @feed, notice: 'Feed was successfully created.'
    else
      render action: 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @feed.update(feed_params)
      redirect_to @feed, notice: 'Feed was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @feed.destroy
    redirect_to @feed, notice: 'Feed was successfully deleted.'
  end


  def feed_params
    params.require(:feed).permit(:name, :url, :feed_type)
  end

  def set_feed
    @feed = Feed.find(params[:id])
  end
end
