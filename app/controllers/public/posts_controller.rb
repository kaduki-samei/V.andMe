class Public::PostsController < ApplicationController

  def index
    @posts = Post.all
    @tag_list=Tag.all
  end

  def new
    @post = Post.new
  end

  def new_confirm
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @tag_names = params.require(:post)[:tag_name].split(" ")
    if @post.invalid?
      flash.now[:notice] = "記入漏れがあります"
      render :new
    end
  end

  def new_back
    @post = Post.new(post_params)
    @tag_names = params[:tag_name].join(" ")
    render :new
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    tag_list = params.require(:post)[:tag_name].split(" ")
    if post.save
      post.save_tag(tag_list)
      flash[:notice] = "記事を投稿しました"
      redirect_to user_path(current_user)
    end
  end

  def show
    @post = Post.find(params[:id])
    @tag_names = @post.tags
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:tag_name).join(" ")
    unless @post.user == current_user
      redirect_to post_path(@post)
    end
  end

  def edit_confirm
    @post = Post.find(params[:id])
    @post.attributes = post_params
    @tag_names = params.require(:post)[:tag_name].split(" ")
    if @post.invalid?
      flash.now[:notice] = "記入漏れがあります"
      render :edit
    end
  end

  def edit_back
    @post = Post.find(params[:id])
    @post.attributes = post_params
    @tag_names = params[:tag_name].join(" ")
    render :edit
  end

  def update
    post = Post.find(params[:id])
    post.attributes = post_params
    tag_list = params[:post][:tag_name].split(" ")
    if post.update(post_params)
      flash[:notice] = "記事が更新されました"
      redirect_to user_path(current_user)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "記事を削除しました"
    redirect_to user_path(current_user)
  end


  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

end
