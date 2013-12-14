class UsersController < ApplicationController
  def new
    render :new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:message] = "Successfully created user #{@user.id}"
      log_in_user!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  def show
    @user = User.find_by_id(params[:id])
    render :show
  end
  
  def index
    @users = User.all
    render :json => @users
  end
  
end