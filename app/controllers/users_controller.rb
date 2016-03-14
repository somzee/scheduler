class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create 
  @user = User.create(user_params) 
    if @user.errors.present?
      flash[:errors] = @user.errors.full_messages
      redirect_to signup_path
    else
      session[:user_id] = @user.id
      redirect_to tasks_path
    end
  end

private
  def user_params
    params.require(:user).permit(:email, :password)
  end


end
