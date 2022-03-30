class Public::PostsController < ApplicationController

  before_action :authenticate_user!,except: [:show, :search_tag]

  def index
    @posts = Post.order(created_at: :DESC)
    @tag_list = Tag.find(PostTag.group(:tag_id).order('count(tag_id) desc').pluck(:tag_id))
  end

  def new
    @post = Post.new
  end

  def new_confirm
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @tag_names = params.require(:post)[:tag_name].split(/[[:blank:]]+/)
    if @post.invalid?
      flash.now[:notice] = "記入漏れがあります"
      render :new
    end
  end

  def new_back
    @post = Post.new(post_params)
    @tag_names = params[:tag_name]
    if @tag_names.present?
      @tag_names = params[:tag_name].join(/[[:blank:]]+/)
    end
    render :new
  end

  def create
    post = Post.new(post_params)
    post.user_id = current_user.id
    tag_list = params[:tag_name]
    if post.save
      if tag_list.present?
        post.save_tag(tag_list)
      end
      flash[:notice] = "記事を投稿しました"
      redirect_to user_path(current_user)
    end
  end

  def show
    @post = Post.find(params[:id])
    @tag_names = @post.tags
    @post_comment = PostComment.new
    @bookmark = Bookmark.find_by(user: current_user, post: @post)
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:tag_name)
    unless @post.user == current_user
      redirect_to post_path(@post)
    end
  end

  def edit_confirm
    @post = Post.find(params[:id])
    @post.attributes = post_params
    @tag_names = params.require(:post)[:tag_name].split(/[[:blank:]]+/)
    if @post.invalid?
      flash.now[:notice] = "記入漏れがあります"
      render :edit
    end
  end

  def edit_back
    @post = Post.find(params[:id])
    @post.attributes = post_params
    @tag_names = params[:tag_name]
    if @tag_names.present?
      @tag_names = params[:tag_name].join(/[[:blank:]]+/)
    end
    render :edit
  end

  def update
    post = Post.find(params[:id])
    post.attributes = post_params
    tag_list = params[:tag_name]
    if post.update(post_params)
      @old_relations = PostTag.where(post_id: post.id)
      @old_relations.each do |relation|
      relation.delete
      end
      post.save_tag(tag_list)
      flash[:notice] = "記事が更新されました"
      redirect_to post_path(post)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "記事を削除しました"
    redirect_to user_path(current_user)
  end

  def search_tag
    @tag_list = Tag.find(PostTag.group(:tag_id).order('count(tag_id) desc').pluck(:tag_id))
    @tag = Tag.find(params[:id])
    @posts = @tag.posts
  end




  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

end
