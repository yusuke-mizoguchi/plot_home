require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe "通知" do
    context "review関連の通知" do
      it "批評がついた際に保存できる" do
        user = create(:user)
        novel = create(:novel, user: user)
        other_user = create(:user, :reader)
        review = create(:review, user: other_user)
        notification = build(:notification, review: review, novel: novel, visitor_id: other_user.id, visited_id: user.id)
        expect(notification).to be_valid
      end
    end
  end
end
