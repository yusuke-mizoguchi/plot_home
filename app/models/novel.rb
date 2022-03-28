class Novel < ApplicationRecord
  belongs_to :user
  has_many :characters, dependent: :destroy
  has_many :reviews, dependent: :destroy

  accepts_nested_attributes_for :characters, reject_if: :all_blank, allow_destroy: true

  validates :title, length: { maximum: 50 }, uniqueness: true, presence: true
  validates :plot, length: { maximum: 5000 }, presence: true

  enum genre: { high_fantasy: 0, low_fantasy: 10, classic: 20, love: 30, comedy: 40, mystery:50,
    reincarnation: 50, speace_fantasy: 60, horror: 70 }
  enum story_length: { long: 0, middle: 1, short: 2 }
  enum release: { release: 0, reader: 1, writer: 2, draft: 3 }
end
