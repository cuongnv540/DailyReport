class SessionsController < ApplicationController

  def new
      if signed_in?
        redirect_to root_path, notice: "Please sign out before sigin"
      end
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password]) && user.active 
      sign_in user
      redirect_back_or user
    else
      if !user.active
        flash.now[:error] = 'User is not actived , Please contact admin to active your account!'
      else
        flash.now[:error] = 'Invalid email/password combination'
      end
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end