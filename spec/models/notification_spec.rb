require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe "通知" do
    context "review関連の通知" do
      before do
        user = build(:user)
        other_user = build(:user, :reader)
        novel = build(:novel)
        review = build(:review)
      end

      it "批評がついた際に保存できる" do
        login(:other_user)
        notification = FactoryBot.build(:notification, review_id: review.id, novel_id: novel.id, visited_id: novel.user_id)
        expect(notification).to be_valid
      end
    end
  end
end
