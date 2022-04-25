require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe "通知" do
    context "review関連の通知" do
      before do
        user = create(:user)
        other_user = create(:user, :reader)
        novel = create(:novel)
        review = create(:review)
      end

      it "批評がついた際に保存できる" do
        login(:other_user)
        notification = build(:notification, review_id: review.id, novel_id: novel.id, visited_id: novel.user_id)
        expect(notification).to be_valid
      end
    end
  end
end
