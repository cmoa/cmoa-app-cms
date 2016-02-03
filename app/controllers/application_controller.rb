class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_admin!
  helper_method :exhibition_is_set

  def set_exhibition
    if params.has_key?(:exhibition_id)
      @exhibition = Exhibition.find(params[:exhibition_id])
      session[:exhibition] = params[:exhibition_id]
    else
      if session.has_key?(:exhibition)
        @exhibition = Exhibition.find(session[:exhibition])
      else
        @exhibition = nil #There isn't an exhibition
      end
    end
  end



  def exhibition_is_set
    return !((defined?(@exhibition)).nil?) #returns true if set otherwise false
  end

end
