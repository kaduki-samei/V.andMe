class Public::RelationshipsController < ApplicationController

  def create
    current_user.follow(params[:user_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.unfollow(params[:id])
    redirect_back(fallback_location: root_path)
  end

  def index
    @users = current_user.followings.all
    @bookmark_posts = Bookmark.includes(:user, :post).where(user_id: current_user.id).order(created_at: :DESC)
  end


end