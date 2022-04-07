require 'rails_helper'

RSpec.describe Character, type: :model do
  describe 'バリデーション' do
    it 'attributes' do
      character = build(:character)
      expect(character).to be_valid
      expect(character.errors).to be_empty
    end
  end
end
