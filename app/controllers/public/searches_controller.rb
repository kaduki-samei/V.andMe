class Public::SearchesController < ApplicationController


  def search
    keywords = params[:keyword].split(/[[:blank:]]+/)

    @tags = []
    keywords.each do |keyword|
      @tags << Tag.find_by(tag_name: keyword)
    end

    @items = []
    @tags.each do |tag|
      posts = tag.posts
      posts.each do |post|
        @items << post
      end
    end

    @posts = @items.group_by{|i| i}.reject{|k,v| v.one?}.keys
  end


end
