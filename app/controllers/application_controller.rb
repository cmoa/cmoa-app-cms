class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_admin!
  helper_method :exhibition_is_set
  helper_method :get_focus

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
      ###
    end
  end

  def unset_exhibition
    session.delete :exhibition
    @exhibition = nil
  end



  def exhibition_is_set
    if @exhibition.blank?
      return false
    else
      return true
    end
  end


  def set_focus(num)
    @focus = num
  end

  def get_focus
    if @focus.blank?
      return ''
    else
      return "focus-#{@focus}"
    end
  end

end
