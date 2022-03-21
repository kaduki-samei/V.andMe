class Public::UsersController < ApplicationController

  before_action :authenticate_user!,except: [:show]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(created_at: :DESC)
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.id == current_user.id
      @user.update(user_params)
      flash[:notice] = "プロフィールが更新されました"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def quit
  end

  def out
    @user = current_user
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会しました"
    redirect_to root_path
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :remove_profile_image)
  end

end
