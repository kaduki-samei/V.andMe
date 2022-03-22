class Public::PostCommentsController < ApplicationController

  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    comment = PostComment.new(post_comment_params)
    comment.user_id = current_user.id
    comment.post_id = post.id
    if comment.save
      flash[:notice] = "コメントしました"
      redirect_to post_path(post)
    else
      flash[:notice] = "コメントできませんでした"
      render post_path(post_comment_params)
    end
  end

  def destroy
    PostComment.find(params[:id]).destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to post_path(params[:post_id])
  end


  private

  def post_comment_params
    params.require(:post_comment).permit(:body)
  end

end
