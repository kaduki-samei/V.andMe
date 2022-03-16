class Follow < ApplicationRecord

  validates :follower_id, presence: true
  validates :followy_id, presence: true

end
