class Admin::PostsController < ApplicationController
  before_action :authenticate_admin! 
  
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "削除に成功しました"
    redirect_to request.referer 
  end
end
