class AdminsController < ApplicationController


  def index
  end

  def new
    @admin = Admin.new
  end

  def create
    pass1 = params[:admin][:password]
    pass2 = params[:admin][:password_again]
    email = params[:admin][:email]

    if pass1.to_s == pass2.to_s #If the passwords match

      @admin = Admin.new
      @admin.email = email
      @admin.password = pass1.to_s

      if @admin.save
        #UserMailer.new_admin(@admin, pass).deliver
        redirect_to action: "index", notice: "An Admin was created."
      else
        render action: 'new'
      end

    end

  end

  def destroy
  end

  def changepass
  end

  def savepass
  end

end
