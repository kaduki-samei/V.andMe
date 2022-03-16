class Post < ApplicationRecord

  belongs_to :user
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :post_comments, dependent: :destroy
  has_many :nices, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_posts, through: :bookmarks, source: :post

  has_rich_text :content

  validates :title, presence: true, length: { minimum: 2, maximum: 30 }


  #ブックマーク
  def bookmark_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end

  #タグ
  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags
    #古いタグを消す
    old_tags.each do |old|
      self.post_tags.delete Tag.find_by(tag_name: old)
    end
    #新しいタグを保存
    new_tags.each do |new|
      p "----DEBUG------"
      p new
      p "----DEBUG------"
      new_post_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_post_tag
    end
  end

end
