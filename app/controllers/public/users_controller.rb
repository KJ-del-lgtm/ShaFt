class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @posts = Post.all
    @post = Post.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def unsubscribe
  end

  def withdraw
    current_user.update(is_active: false)
    sign_out current_user
    redirect_to root_path, notice:"退会が完了しました"
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :is_active)
  end
end
