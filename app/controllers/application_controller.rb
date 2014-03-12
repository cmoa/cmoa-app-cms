class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_admin!

  def set_exhibition
    @exhibition = Exhibition.find(params[:exhibition_id])
  end
end
