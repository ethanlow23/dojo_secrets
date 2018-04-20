class UsersController < ApplicationController
  def index
  end
  def new
    session[:user_id] = nil
  end
  def create
    @user = User.new(params.require(:user).permit(:name, :email, :password, :password_confirmation))
    if @user.save
      session[:user_id] = @user.id
      redirect_to sessions_new_path
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to users_new_path
    end
  end
  def show
  end
  def edit
  end
  def update
    @user = User.update(current_user.id, params.require(:user).permit(:name, :email, :password, :password_confirmation))
    if @user.save
      redirect_to "/users/#{current_user.id}/edit"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to "/users/#{current_user.id}/edit"
    end
  end
  def destroy
    User.find(current_user.id).destroy
    redirect_to users_new_path
  end
end
