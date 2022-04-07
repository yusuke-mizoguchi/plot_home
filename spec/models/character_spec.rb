require 'rails_helper'

RSpec.describe Character, type: :model do
  describe 'バリデーション' do
    it 'attributes' do
      character = build(:character)
      expect(character).to be_valid
      expect(character.errors).to be_empty
    end

    it 'character_role文字数超過' do
      character_over_character_role = build(:character, character_role: "a" * 20)
      expect(character_over_character_role).to be_invalid
      expect(character_over_character_role.errors[:character_role]).to eq ["can't be over"]
    end

    it 'character_text文字数超過' do
      character_over_character_text = build(:character, character_text: "a" * 3001)
      expect(character_over_character_text).to be_invalid
      expect(character_over_character_role.errors[:character_text]).to eq ["can't be over"]
    end
  end
end
