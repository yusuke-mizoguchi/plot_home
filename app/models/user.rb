class User < ApplicationRecord
  has_many :novels, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :active_notifications, class_name: "Notification", foreign_key:"visitor_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key:"visited_id", dependent: :destroy

  has_rich_text :profile

  authenticates_with_sorcery!

  validates :password, length: { minimum: 4, maximum: 20 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :name, length: { maximum: 30 }, presence: true
  validates :email, uniqueness: true, presence: true
  validates :role, presence: true
  validates :reset_password_token, uniqueness: true, allow_nil: true
  validate :profile_word_count

  enum role: { writer: 10,  reader: 20}

  def own?(object)
    id == object.user_id
  end

  private

  def profile_word_count
    errors.add(:profile, I18n.t('defaults.message.over_profile')) unless ApplicationController.helpers.strip_tags(profile.to_s).gsub(/[\n]/,"").strip.length < 5001
  end
end
