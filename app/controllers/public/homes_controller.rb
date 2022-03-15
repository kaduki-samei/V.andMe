class Public::HomesController < ApplicationController

  def top
    @posts = Post.all
    @posts = Post.order(created_at: :DESC)
  end

  def about
  end

end
