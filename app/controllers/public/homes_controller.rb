class Public::HomesController < ApplicationController

  def top
    @posts = Post.all
    @posts = Post.order(created_at: :DESC)
    @tag_list = Tag.find(PostTag.group(:tag_id).order('count(tag_id) desc').pluck(:tag_id))
  end

  def about
  end

end
