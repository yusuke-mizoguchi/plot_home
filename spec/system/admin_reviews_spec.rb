require 'rails_helper'

RSpec.describe "AdminReviews", type: :system do
    let!(:admin) { create(:user, :admin) }
    let!(:reader) { create(:user, :reader) }
    let!(:novel) { create(:novel, user: admin) }
    let!(:review) { create(:review, novel: novel, user: reader) }

    before
        login(admin)
        visit edit_admin_reviews_path(review)

        describe '批評編集' do

            context 'フォームの入力値が正常' do
                it '批評編集が成功する' do
                    fill_in '良い点', with: 'update_good'
                    fill_in '改善点', with: 'update_bad'
                    click_button '更新する'
                    expect(page).to have_content 'update_good'
                    expect(page).to have_content 'update_bad'
                    expect(current_path).to eq admin_review_path(review)
                end
            end

            context 'good_pointが未入力' do
                it '批評編集が失敗する' do
                    fill_in '良い点', with: ''
                    fill_in '改善点', with: 'update_bad'
                    click_button '更新する'
                    expect(page).to have_content '良い点を入力してください'
                    expect(current_path).to eq edit_admin_review_path(review)
                end
            end

            context '字数制限超過' do
                it '批評編集が失敗する' do
                    fill_in '良い点', with: 'g' * 1501
                    fill_in '改善点', with: 'b' * 1501
                    click_button '更新する'
                    expect(page).to have_content '良い点は1500文字以内で入力してください'
                    expect(page).to have_content '改善点は1500文字以内で入力してください'
                    expect(current_path).to eq edit_admin_review_path(review)
                end
            end
        end

        describe '返信編集' do
            let!(:reply) { create(:review, parent_id: review.id, novel: novel, user: admin) }

            context '入力値が正常' do
                it '編集が成功する' do
                    fill_in '返信', with: 'update-reply'
                    click_button '更新する'
                    expect(page).to have_content '批評を更新しました'
                    expect(current_path).to eq admin_review_path(reply)
                end
            end

            context '字数制限超過' do
                it '編集が失敗する' do
                    fill_in '返信', with: 'r' * 1001
                    click_button '更新する'
                    expect(page).to have_content '返信は1000文字以内で入力してください'
                    expect(current_path).to eq admin_review_path(reply)
                end
            end
        end

        describe '批評削除' do
            it '批評の削除が成功する' do
                visit admin_review_path(review)
                page.accept_confirm("削除しますか？") do
                    click_button '削除'
                end
                expect(page).to have_content '批評を削除しました'
                expect(current_path).to eq admin_reviews_path
            end
        end
end