class Character < ApplicationRecord
  belongs_to :novel

  validates :character_text, length: { maximum: 2000 }
  validates :character_text, length: { maximum: 2000 }
  validates :character_role, length: { maximum:20 }
end
