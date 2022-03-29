class Public::SearchesController < ApplicationController


  def search
    @keywords = params[:keyword].split(/[[:blank:]]+/)
    @tags = Tag.where(tag_name: @keywords).pluck(:id)
    @posts_result = []

    @tags.each do |k|
      @posts = Post.joins(:post_tags).where(post_tags: {tag_id: k}).pluck(:id)
      @posts.each do |p|
        @posts_result.push(p)
      end
    end

    @post_ids = @posts_result.uniq.map{|item| [item, @posts_result.count(item)]}.to_h.find_all{|k, v| v == @tags.length}.to_h
    @posts = Post.where(id: @post_ids.keys)


    @tag_list = Tag.find(PostTag.group(:tag_id).order('count(tag_id) desc').pluck(:tag_id))
  end


end
