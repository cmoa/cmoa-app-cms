class AdminsController < ApplicationController


  def index
    @admins = Admin.all
  end

  def new
    @admin = Admin.new
  end

  def create
    pass1 = params[:admin][:password]
    pass2 = params[:admin][:password_confirmation]
    email = params[:admin][:email]

    if pass1.to_s == pass2.to_s #If the passwords match

      @admin = Admin.new
      @admin.email = email
      @admin.password = pass1.to_s

      if @admin.save
        #UserMailer.new_admin(@admin, pass).deliver
        redirect_to action: "index"
      else
        render action: 'new'
      end

    end

  end

  def destroy
    @admin = Admin.find(params[:id])
    @admin.destroy
    redirect_to action: "index"
  end

  def profile
    @admin = current_admin
  end

  def save_profile
    @admin = Admin.find(current_admin.id)

    if @admin.update(admin_params)
      sign_in @admin, :bypass => true
      redirect_to root_path
    else
      render "profile"
    end
  end

private

  def admin_params
    params.require(:admin).permit(:password, :password_confirmation, :email)
  end

end
