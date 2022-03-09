class Public::UsersController < ApplicationController

  def show
  end

  def edit
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
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
