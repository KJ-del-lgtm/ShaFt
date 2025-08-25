class Public::ShiftsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group

  def new
    @shift = @group.shifts.new(start_time: params[:date])
    @group_members = @group.users
  end

  def create
    @shift = @group.shifts.new(shift_params)
    @shift.user = current_user  
    if @shift.save
      redirect_to group_path(@group), notice: "シフトを追加しました"
    else
      render :new
    end
  end

  def edit
    @shift = Shift.find(params[:id])
  end

  def update
    @shift = @group.shifts.find(params[:id])
    if @shift.update(shift_params)
      redirect_to group_path(@group), notice: "シフト更新しました"
    else
      render :edit
    end
  end

  def destroy
    @shift = @group.shifts.find(params[:id])
    @shift.destroy
    redirect_to group_path(@group), notice: "シフトを削除しました"
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def shift_params
    params.require(:shift).permit(:user_id, :start_time, :end_time)
  end
end
