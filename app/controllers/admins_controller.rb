class AdminsController < ApplicationController


  def index
  end

  def new
    @admin = Admin.new
  end

  def create
    pass = Devise.friendly_token.first(8)
    email = params[:admin][:email]

    @admin = Admin.new
    @admin.email = email
    @admin.password = pass

    if @admin.save
      #RegistrationMailer.welcome(@admin, pass).deliver
      UserMailer.new_admin(@admin, pass).deliver
      redirect_to action: "index", notice: "An Admin was created.  A password was sent to them."
    else
      render action: 'new'
    end

  end

  def destroy
  end

  def changepass
  end

  def savepass
  end

end
