class Public::MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group

  def create
    @message = @group.messages.new(message_params)
    @message.user = current_user
    if @message.save
      redirect_to request.referer
    else
      flash[:alert] = "メッセージを入れてください"
      redirect_to request.referer
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
