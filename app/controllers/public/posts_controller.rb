class Public::PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def new_confirm
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.invalid?
      flash.now[:notice] = "記入漏れがあります"
      render :new
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if params[:back]
      render :new
    else @post.save
      flash[:notice] = "記事を投稿しました"
      redirect_to post_path(@post)
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end

  def edit_confirm
  end

  def update
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "記事を削除しました"
    render user_path(current_user)
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

end
