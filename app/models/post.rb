class Post < ApplicationRecord

  belongs_to :user
  has_many :post_tags,dependent: :destroy
  has_many :tags,through: :post_tags
  has_many :post_comments
  has_many :nices
  has_many :bookmarkss

  has_rich_text :content

  validates :title, presence: true, length: { minimum: 2, maximum: 30 }

end
