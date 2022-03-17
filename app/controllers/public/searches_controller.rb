class Public::SearchesController < ApplicationController

  def search
    keywords = params[:keyword].split(/[[:blank:]]+/)
    @tags = Tag.all
    keywords.each do |keyword|
      @tags = @tags.where("tag_name LIKE ?", "%#{keyword}%")
    end
  end


end
