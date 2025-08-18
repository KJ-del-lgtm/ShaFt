class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only:[:edit, :destroy]
  
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "TODOを作りました!"
      redirect_to post_path(@post)
    else
      flash[:notice] = "TODOを入れてください"
      render :new 
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "TODOを更新しました!"
      redirect_to post_path(@post.id)
    else
      flash[:notice] = "TODOを入れてください"
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_path(@post.user.id)
  end

  private
  def post_params
    params.require(:post).permit(:content, :public, :group_id)
  end

  def is_matching_login_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      flash[:notice] = "他のユーザーの編集削除はできません"
      redirect_to user_path(current_user)
    end
  end
end
