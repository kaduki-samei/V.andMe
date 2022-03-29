class Public::BookmarksController < ApplicationController

  before_action :authenticate_user!

  def index
    @bookmarks = current_user.bookmarks
    @bookmark_posts = Bookmark.includes(:user, :post).where(user_id: current_user.id).order(created_at: :DESC)
  end

  def create
    @post = Post.find(params[:post_id])
    user = current_user
    @bookmark = Bookmark.new(post_id: @post.id, user_id: user.id)
    @bookmark.save
  end

  def destroy
    @post = Post.find(params[:post_id])
#    bookmark = current_user.bookmarks.find_by(post_id: post.id)
    bookmark = Bookmark.where(id: params[:id], user: current_user)
    if bookmark != nil
      bookmark.destroy_all
    else
      @bookmark = Bookmark.find_by(id: params[:id])
      flash[:error] = "エラーが発生しました。"
    end
  end

end
