class Novel < ApplicationRecord
  belongs_to :user
  has_many :characters, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_rich_text :plot

  accepts_nested_attributes_for :characters, reject_if: :all_blank, allow_destroy: true

  validates :title, length: { maximum: 50 }, uniqueness: true, presence: true
  validates :plot, length: { maximum: 5000 }, presence: true
  validates :genre, presence: true
  validates :story_length, presence: true
  validates :release, presence: true

  enum genre: { high_fantasy: 10, low_fantasy: 20, classic: 30, love: 40, love_comedy: 50,
    gag: 60, mystery:70, reincarnation: 80, speace_fantasy: 90, horror: 100 }
  enum story_length: { long: 5, middle: 15, short: 25 }
  enum release: { release: 1, reader: 2, writer: 3, draft: 4 }
end
