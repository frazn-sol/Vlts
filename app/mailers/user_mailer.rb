class UserMailer < ActionMailer::Base
  default from: "no.reply.vlts@gmail.com"

  def welcome_email(user)
    @user = user
    @url  = "#{root_url}/users"
    mail(to: @user.email, subject: 'Account successfully created')
  end
end
