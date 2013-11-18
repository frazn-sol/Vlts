class UserMailer < ActionMailer::Base
  default from: "no.reply.vlts@gmail.com"

  def welcome_email(user)
    @user = user
    @url  = "#{root_url}users"
    mail(to: @user.email, subject: 'Account successfully created')
  end

  def forgot_email_to_user(user)
  	@user = user
  	mail(to: @user.email, subject: "Password Reset Request")
  end

  def forgot_email_to_admin(user, admin)
  	@user = user
  	@user1 = admin
  	mail(to: @user1[0].email, subject: "Password Reset Request")
  end

  def reset_email(user)
  	@user = user
  	@url  = "#{root_url}users"
  	mail(to: @user.email, subject: "Your Password Has Been Reset")
  end
end
