class Novel < ApplicationRecord
  belongs_to :user
  has_many :characters, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :notifications, dependent: :destroy

  has_rich_text :plot

  accepts_nested_attributes_for :characters, reject_if: :all_blank, allow_destroy: true

  validates :title, length: { maximum: 50 }, uniqueness: true, presence: true
  validates :genre, presence: true
  validates :story_length, presence: true
  validates :release, presence: true
  validate :plot_required

  enum genre: { high_fantasy: 10, low_fantasy: 20, classic: 30, love: 40, love_comedy: 50,
    gag: 60, mystery:70, reincarnation: 80, speace_fantasy: 90, horror: 100 }
  enum story_length: { long: 5, middle: 15, short: 25 }
  enum release: { release: 1, reader: 2, writer: 3, draft: 4 }

  #通知用メソッド
  def create_notification_review!(current_user, review_id)
    temp_ids = Review.where(novel_id: id).select(:user_id).where.not(
                "user_id = ? or user_id = ?", current_user.id, user_id).distinct 
    temp_ids.each do |temp_id|
      save_notification_review!(current_user, review_id, temp_id['user_id'])
    end
    save_notification_review!(current_user, review_id, user_id)
  end

  def save_notification_review!(current_user, review_id, visited_id)
    notification = current_user.active_notifications.new(
      novel_id: id,
      review_id: review_id,
      visited_id: visited_id,
    )
    if notification.visitor_id == notification.visited_id
      notification.destroy
    end
    notification.save if notification.valid?
  end

  private

  def plot_required
    errors.add(:plot, I18n.t('defaults.message.nill_plot')) unless plot.body.present?
    errors.add(:plot, I18n.t('defaults.message.over_plot')) unless ApplicationController.helpers.strip_tags(plot.to_s).gsub(/[\n]/,"").strip.length < 8001
  end
end
