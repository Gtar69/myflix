class SessionsController < ApplicationController
  
  def new
    redirect_to home_path if current_user
  end
  
  def create
    u = User.where(email: params[:email]).first
    if u && u.authenticate(params[:password])
      session[:user_id]= u.id
      redirect_to home_path, notice: "You are signed in, enjoy!" 
    else
      flash[:error] = "Invalid email or password."
      redirect_to sign_in_path
    end  
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You are signed out."
  end



end
