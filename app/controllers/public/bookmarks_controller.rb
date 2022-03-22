class Public::BookmarksController < ApplicationController

  before_action :authenticate_user!

  def index
    @bookmarks = current_user.bookmarks
    @bookmark_posts = current_user.bookmark_posts.includes(:user).order(created_at: :DESC)
  end

  def create
    post = Post.find(params[:post_id])
    user = current_user
    bookmark = Bookmark.new(post_id: post.id, user_id: user.id)
    if bookmark.save
      flash[:notice] = "ブックマークしました"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    post = Post.find(params[:post_id])
    bookmark = current_user.bookmarks.find_by(post_id: post.id)
    bookmark.destroy
    @post = Post.find(params[:id])
  end

end
