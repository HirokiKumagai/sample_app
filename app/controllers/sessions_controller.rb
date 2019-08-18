class SessionsController < ApplicationController

  def new
  end

  def create
    a_user = User.find_by(email: params[:session][:email].downcase)
    if a_user && a_user.authenticate(params[:session][:password])
      log_in a_user
      params[:session][:remember_me] == '1' ? remember(a_user) : forget(a_user)
      redirect_to a_user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
