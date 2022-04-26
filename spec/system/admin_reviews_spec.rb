require 'rails_helper'

RSpec.describe "AdminReviews", type: :system do
    let(:admin) { create(:user, :admin) }
    let(:reader) { create(:user, :reader) }
    let(:novel) { create(:novel, user_id: admin.id) }
    let(:review) { create(:review, novel_id: novel.id, user_id: reader.id) }
    let(:reply) { create(:review, parent_id: review.id, novel_id: novel.id, user_id: novel.user_id) }

    before do
        login(admin)
        visit admin_reviews_path
    end
end