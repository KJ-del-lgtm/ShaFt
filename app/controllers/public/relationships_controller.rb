class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :forbid_guest_action

  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    redirect_to request.referer
  end

  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    redirect_to request.referer
  end

  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end

  private

  def forbid_guest_action
    @user = User.find(params[:user_id])
    if current_user.guest?
      redirect_to root_path, alert: "ゲストユーザーはフォロー機能を利用できません。"
    end
  end
end
