class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by(name: params[:session][:name].downcase)
    if user
      log_in(user)
      remember user
      flash[:success] = 'You are now logged in'
      redirect_to root_path
    else
      flash[:danger] = 'Invalid user'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end


end
