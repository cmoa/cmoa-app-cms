class UserMailer < ActionMailer::Base
  default from: "no-reply@carnegiemuseums.org"

  def new_admin(user, pass)
    @user = user
    @pass = pass
    mail(to: @user.email, subject: 'Oakland CMS Admin')
  end
end
