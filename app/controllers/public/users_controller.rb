class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :authenticate_user!
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @posts = current_user.posts.order(:due_date)
  end
  
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "ユーザー更新しました!"
      redirect_to user_path(@user)
    else
      flash[:notice] = "ユーザー更新失敗しました"
      render :edit
    end
    
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

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
end
