require 'rails_helper'

RSpec.describe "Reviews", type: :system do
  let(:user) { create(:user) }
  let(:novel) { create(:novel, user: user) }
  let(:other_user) { create(:user, :reader) }
  let!(:review) { create(:review, novel: novel, user: other_user) }

  describe '通知が作成される' do
    context '自分の作品に批評がついた時' do
    it '通知のお知らせがある' do
        login(user)
        unchecked_notifications.any? == true
      end

      it '通知一覧に通知がある' do
        login(user)
        visit notifications_path
        expect(page).to have_content "#{other_user.name}さんが#{novel.titke}にコメントしました"
      end
    end

    context '自分の批評に返信がついた時' do
      let!(:reply) { create(:review, parent_id: review.id, novel: novel, user: user) }

      it '通知のお知らせがある' do
        login(other_user)
        unchecked_notifications.any? == true
      end

      it '通知一覧に通知がある' do
        login(other_user)
        visit notifications_path
        expect(page).to have_content "#{user.name}さんが#{novel.title}にコメントしました"
      end
    end
  end

  describe '通知の削除' do
    it '通知の削除が成功する' do
      visit notifications_path
      click_link '通知を削除'
      expect(page).to have_content '通知を削除しました'
      expect(current_path).to eq notifications_path
    end
  end
end
