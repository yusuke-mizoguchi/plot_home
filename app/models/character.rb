class Character < ApplicationRecord
  belongs_to :novel

  has_rich_text :character_text

  validates :character_text, length: { maximum: 2000 }
  validates :character_role, length: { maximum:20 }
end
