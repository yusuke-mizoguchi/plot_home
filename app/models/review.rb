class Review < ApplicationRecord
  belongs_to :user
  belongs_to :novel
  belongs_to :parent, class_name: 'Review', optional: true
  has_many   :replies, class_name: 'Review', foreign_key: :parent_id, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :good_point, presence: true, length: { maximum: 1500 }
  validates :bad_point, length: { maximum: 1500 }
  validates :comment, length: { maximum: 100 }
end
