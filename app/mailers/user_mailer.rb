class UserMailer < ActionMailer::Base
  @from_email = SystemConfig.find(1).from.to_s
  if @from_email.blank?
    @from_email = "no.reply.vlts@gmail.com"
  end

  default from: @from_email

  def welcome_email(user)
    @user = user
    @url  = "#{root_url}users"
    mail(to: @user.email, subject: 'Account successfully created')
  end

  def contact_message(message)
    @to_email = SystemConfig.find(1).to.to_s
    if @to_email.blank?
      @to_email = "no.reply.vlts@gmail.com"
    end
    @message = message
    mail(to: @to_email, subject: 'Contact Request')
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
