class UserMailer < ActionMailer::Base
  default from: "catbui7583@gmail.com"

  
  def welcome_email(user)
    @user = user
    @url  = "http://localhost:3000/signin"
    mail(:to => user.email, :subject => "Welcome to Daily report")
  end

  def admin_email(user)
    @user = user
    @url  = "http://localhost:3000/signin"
    mail(:to => "catbui7583@gmail.com", :subject => "Active new account !")
  end

  def send_email(user)
    @user = user 
    mail(:to => "catbui7583@gmail.com", :subject => "Daily report")
  end
end
