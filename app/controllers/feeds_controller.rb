class FeedsController < ApplicationController

  def index
    @feeds = Feed.all
  end

  def new
    @feed = Feed.new
  end


  def feed_params
    params.require(:feed).permit(:name, :url, :type)
  end
end
