class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :authentication_keys => [:name]

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  mount_uploader :profile_image, ImageUploader



  validates :name, presence: true, length: { minimum: 1, maximum: 15 }
  validates :introduction, length: { maximum: 60 }


  def email_required?
    false
  end
  def email_changed?
    false
  end

end
