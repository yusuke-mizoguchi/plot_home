class Character < ApplicationRecord
  belongs_to :novel

  has_rich_text :character_text

  validates :character_role, length: { maximum: 20 }
  validate :character_text_word_count

  private

  def character_text_word_count
    errors.add(:character_text, I18n.t('defaults.message.over_character_text')) unless ApplicationController.helpers.strip_tags(character_text.to_s).gsub(/[\n]/,"").strip.length < 5001
  end
end
