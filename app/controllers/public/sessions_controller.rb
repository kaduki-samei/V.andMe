# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :user_state, only: [:create]
  before_action :configure_permitted_parameters, only: [:create]


  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def after_sign_in_path_for(resource)
    flash[:notice] = "ログインしました"
    posts_path
  end

  def after_sign_out_path_for(resource)
    flash[:notice] = "ログアウトしました"
    root_path
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
  end


  #退会しているかを判断するメソッド
  def user_state
    @user = User.find_by(name: params[:user][:name])
    return if !@user
    if @user.valid_password?(params[:user][:password]) && (@user.is_active == false)
      flash[:notice] = "退会済みです。新規登録を行なってください。"
      redirect_to new_user_registration_path
    end
  end

end