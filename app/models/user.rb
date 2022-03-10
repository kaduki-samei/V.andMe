class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :authentication_keys => [:name]

  has_many :posts, dependent: :destroy

  mount_uploader :profile_image, ImageUploader

  def email_required?
    false
  end
  def email_changed?
    false
  end

end
