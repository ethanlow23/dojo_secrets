class SecretsController < ApplicationController
  def index
    @secrets = Secret.all
  end
  def create
    @secret = User.find(current_user.id).secrets.new(content: params[:Content])
    if @secret.save
      redirect_to "/users/#{current_user.id}"
    else
      flash[:errors] = @secret.errors.full_messages
      redirect_to "/users/#{current_user.id}"
    end
  end
  def liked
    if params[:secret] == "like"
      User.find(current_user.id).likes.create(secret:Secret.find(params[:secret_id]))
    end
    if params[:secret] == "unlike"
      User.find(current_user.id).likes.find(params[:secret_id]).destroy
    end
    redirect_to secrets_path
  end
  def destroy
    Secret.find(params[:secret_id]).destroy
    redirect_to "/users/#{current_user.id}"
  end
end
