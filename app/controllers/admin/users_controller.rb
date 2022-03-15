class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @user = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.is_active == true
      @user.update(is_active: false)
      flash[:notice] = "#{@user.name}さんを停止しました"
      redirect_to admin_users_path
    else
      @user.update(is_active: true)
      flash[:notice] = "#{@user.name}さんが復活しました"
      redirect_to admin_users_path
    end
  end

end
