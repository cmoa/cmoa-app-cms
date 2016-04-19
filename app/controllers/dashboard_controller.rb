class DashboardController < ApplicationController
  before_filter :authenticate_admin!

  before_action do
    set_focus('home')
  end

  def index
    unset_exhibition
    @total_beacons = Beacon.all.size
    @total_categories = Category.all.size
    @total_exhibitions = Exhibition.all.size

    @total_feeds = Feed.all.size
    @total_locations = Location.all.size

  end
end
