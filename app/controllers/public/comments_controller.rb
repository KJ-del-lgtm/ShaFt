class Public::CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = post.id 
    if comment.save
      redirect_to post_path(post)
    else
      flash[:notice] = "コメントに失敗しました"
      redirect_to post_path(post)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
