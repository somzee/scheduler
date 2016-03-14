class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_email(params[:session][:email])
      if @user && @user.authenticate(params[:session][:password_digest])
        session[:user_id] = @user.id
        redirect_to '/'
      else
        redirect_to 'login'
        flash[:errors] = @user.errors.full_messages
      end 
  end

  def destroy 
    session[:user_id] = nil 
    redirect_to '/' 
  end
    
end