class Public::GroupUsersController < ApplicationController
  before_action :authenticate_user!


  def create
    user = User.find(params[:user_id])
    if current_user.matual_following?(user) && @group.users.count < 10
      @group.users << user unless @group.users.include?(user)
      redirect_to @group, notice: "#{user.name}さんを招待しました"
    else
      redirect_to @group, alert: "招待できません"
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end
end
