class SessionsController < ApplicationController
  def new
  end
  def create
    if User.find_by_email(params[:email]).try(:authenticate, params[:password])
      session[:user_id] = User.find_by_email(params[:email]).id
      redirect_to "/users/#{current_user.id}"
    else
      flash[:errors] = ["Invalid Combination"]
      redirect_to sessions_new_path
    end
  end
  def destroy
    session[:user_id] = nil
    redirect_to sessions_new_path
  end
end
