require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'バリデーション' do
    it 'attributes' do
      review = build(:review)
      expect(review).to be_valid
      expect(review.errors).to be_empty
    end

    it 'good_point空白' do
      review_without_good_point = build(:review, good_point: nil)
      expect(review_without_good_point).to be_invalid
      expect(review_without_good_point.errors[:good_point]).to eq["can't be blank"]
    end
  end
end
