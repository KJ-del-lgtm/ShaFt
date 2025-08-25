class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user
  before_action :authorize_member!, only:[:show, :edit, :update, :destroy]

  def index
    @groups = (current_user.groups + current_user.owned_groups).uniq
  end

  def show
    @group = Group.find(params[:id])
    @shifts = @group.shifts.includes(:user)
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.owned_groups.build(group_params)
  if @group.save
    @group.users.each do |user|
      (Date.today.beginning_of_month..Date.today.end_of_month).each do |day|
        Shift.create!(
          group: @group,
          user: user,
          start_time: day.to_datetime.change(hour: 9),   # デフォルト 9:00
          end_time: day.to_datetime.change(hour: 18)     # デフォルト 18:00
        )
      end
    end
    redirect_to @group, notice: "グループを作成しました（シフト表も自動生成済み）"
  else
    render :new
  end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    redirect_to groups_path , notice: "グループを削除しました"
  end

  private

  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end

  def ensure_guest_user
    if current_user.email == "guest@example.com"
      redirect_to user_path(current_user) , notice: "ゲストユーザーは利用できません。"
    end
  end 

  def authorize_member!
    @group = Group.find(params[:id])
    unless @group.users.include?(current_user) || @group.owner == current_user
      redirect_to root_path, alert: "このグループにはアクセスできません。"
    end
  end
end
