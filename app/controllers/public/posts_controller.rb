class Public::PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def confirm
    @post = Post.new(post_params)
    render :new if @post.invalid?
  end

  def create
    @post = Post.new(post_params)
    if params[:back]
      render :new
    else @post.save
      redirect_to post_path(@post)
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end


  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

end
