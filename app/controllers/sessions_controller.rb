class SessionsController < ApplicationController
  def create
    email = params[:user][:email]
    secret = params[:user][:password]
    @user = User.find_by_credentials(email, secret)
    if @user
      log_in_user!(@user)
      flash[:message] = "Successfully logged in as user #{@user.id}"
      redirect_to user_url(@user)
    else
      flash[:errors] = ["Invalid email or password"]
      render :new
    end
  end
  
  def new
    render :new
  end
  
  def destroy
    @user = current_user
    logout!(@user)
    redirect_to user_url(@user)
  end
end