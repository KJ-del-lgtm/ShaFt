class Admin::UsersController < ApplicationController
  before_action :authenticate_admin! 

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def withdraw
    user = User.find(params[:id])
    user.update(is_active: false)
    redirect_to admin_users_path, notice: "#{user.name}さんを退会させました。"
  end
  
end
