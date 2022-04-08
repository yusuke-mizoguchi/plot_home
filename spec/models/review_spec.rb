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
      expect(review_without_good_point.errors[:good_point]).to eq ["を入力してください"]
    end

    it 'good_point文字数超過' do
      review_over_good_point = build(:review, good_point: "a" * 1501)
      expect(review_over_good_point).to be_invalid
      expect(review_over_good_point.errors[:good_point]).to eq ["は1500文字以内で入力してください"]
    end

    it 'badd_point文字数超過' do
      review_over_bad_point = build(:review, bad_point: "a" * 1501)
      expect(review_over_bad_point).to be_invalid
      expect(review_over_bad_point.errors[:bad_point]).to eq ["は1500文字以内で入力してください"]
    end
  end
end
