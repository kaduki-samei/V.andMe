class Public::NicesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    alreadynice = Nice.find_by(ip_address: access_user, post_id: post.id)
    if alreadynice
      flash[:notice] = "すでにナイスを送っています"
      redirect_back(fallback_location: root_path)
    else
      nice = Nice.create(post_id: post.id, ip_address: access_user)
      redirect_back(fallback_location: root_path)
    end
  end


  private

  def access_user
    request.remote_ip
  end

end
