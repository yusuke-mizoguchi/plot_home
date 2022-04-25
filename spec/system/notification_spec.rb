require 'rails_helper'

RSpec.describe "Reviews", type: :system do
    let(:user) { create(:user) }
    let!(:novel) { create(:novel, user_id: user.id) }
    let!(:other_user) { create(:user, :reader) }
    let!(:review) { create(:review, novel_id: novel.id, user_id: other_user.id) }
end
