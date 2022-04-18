class Review < ApplicationRecord
  belongs_to :user
  belongs_to :novel
  has_many :notifications, dependent: :destroy

  validates :good_point, presence: true, length: { maximum: 1500 }
  validates :bad_point, length: { maximum: 1500 }
end
