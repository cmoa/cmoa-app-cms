class DashboardController < ApplicationController
  before_filter :authenticate_admin!

  def index
    @total_beacons = Beacons.all.size
    @total_categories = Categories.all.size
    @total_exhibitions = Exhibitions.all.size

    @total_feeds = Feeds.all.size
    @total_locations = Locations.all.size
    
  end
end
