class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin! 

  def index
    @comments = Comment.all.includes(:user, :post)
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to request.referer 
  end
  
end
