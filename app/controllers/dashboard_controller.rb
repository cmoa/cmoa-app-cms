class DashboardController < ApplicationController
  before_filter :authenticate_admin!

  def index
    redirect_to exhibitions_path
  end
end