class Message < ApplicationRecord

  validates :name, presence: true
  validates :email, presence: true, length: { maximum: 50 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 400 }

end
