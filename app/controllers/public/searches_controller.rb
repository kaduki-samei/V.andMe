class Public::SearchesController < ApplicationController


  def search
    @keywords = params[:keyword].split(/[[:blank:]]+/)

    @tags = Tag.where(tag_name: @keywords).pluck(:id)
  
    # ID, カラム
    # 1, タグ1, タグ2, タグ3
    # 2, タグ2, タグ3
    # 3, タグ3
    # １個目のキーワード"タグ1"
    # @posts_result = [1]
    # ２個目のキーワード"タグ2"
    # @posts_result = [1, 1, 2] 
    # ３個目のキーワード"タグ3"
    # @posts_result = [1, 1, 2, 1, 2, 3] 
    # それぞれカウントをとる
    # @post_ids = {{1 => 3}, {2 => 2}, {3 => 1}}
    # キーワードの検索数=全てに一致するなので
    # 今回キーワードは"タグ1", "タグ2", "タグ3"の三つあるので
    # 三つ持っている1 のみが検索結果として正しい
  
    @posts_result = []
    @tags.each do |k|
      @posts = Post.joins(:post_tags).where(post_tags: {tag_id: k}).pluck(:id)
      @posts.each do |p|
        @posts_result.push(p)
      end
    end
    @post_ids = @posts_result.uniq.map{|item| [item, @posts_result.count(item)]}.to_h.find_all{|k, v| v == @tags.length}.to_h
    @posts = Post.where(id: @post_ids.keys)


#    @tags = []
#    @keywords.each do |keyword|
#      @tags << Tag.find_by(tag_name: keyword)
#    end
#
#    @items = []
#    @tags.each do |tag|
#      posts = tag.posts#
#      posts.each do |post|
#        @items << post
#      end
#    end
#
#    @posts = @items.group_by{|i| i}.reject{|k,v| v.one?}.keys
  end


end
