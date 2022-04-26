require 'rails_helper'

RSpec.describe "Reviews", type: :system do
  let(:user) { create(:user) }
  let(:novel) { create(:novel, user: user) }
  let(:other_user) { create(:user, :reader) }

  describe 'ログイン後' do
    before { login(other_user) }

      describe '批評投稿' do
        context 'フォームの入力値が正常' do
          it '批評投稿が成功する' do
            visit novel_path(novel)
            fill_in 'review[good_point]', with: 'good_point'
            fill_in 'review[bad_point]', with: 'bad_point'
            click_button '投稿する'
            expect(page).to have_content 'good_point'
            expect(page).to have_content 'bad_point'
            expect(current_path).to eq novel_path(novel)
          end
        end

        context 'good_pointが未入力' do
          it '批評投稿が失敗する' do
          visit novel_path(novel)
            fill_in 'review[good_point]', with: ''
            fill_in 'review[bad_point]', with: 'bad_point'
            click_button '投稿する'
            expect(page).to have_content '良い点を入力してください'
            expect(current_path).to eq novel_path(novel)
          end
        end

        context '字数制限超過' do
          it '批評投稿が失敗する' do
          visit novel_path(novel)
            fill_in 'review[good_point]', with: 'g' * 1501
            fill_in 'review[bad_point]', with: 'b' * 1501
            click_button '投稿する'
            expect(page).to have_content '良い点は1500文字以内で入力してください'
            expect(page).to have_content '改善点は1500文字以内で入力してください'
            expect(current_path).to eq novel_path(novel)
          end
        end
      end

      describe '批評編集' do
        let!(:review) {create(:review, user: other_user, novel: novel)}

        context 'フォームの入力値が正常' do
          it '批評編集が成功する' do
            visit novel_path(novel)
            find('.js-edit-review-button').clickgit 
            find("input[value='#{review.good_point}']").set('update_good')
            find("input[value='#{review.bad_point}']").set('update_bad')
            click_button '更新する'
            expect(page).to have_content 'update_good'
            expect(page).to have_content 'update_bad'
            expect(current_path).to eq novel_path(novel)
          end
        end

        context 'good_pointが未入力' do
          it '批評編集が失敗する' do
            visit novel_path(novel)
            find('.js-edit-review-button').click
            find("input[value='#{review.good_point}']").set('')
            find("input[value='#{review.bad_point}']").set('update_bad')
            click_button '更新する'
            expect(page).to have_content '良い点を入力してください'
            expect(current_path).to eq novel_path(novel)
          end
        end

        context '字数超過' do
          it '批評編集が失敗する' do
            visit novel_path(novel)
            find('.js-edit-review-button').click
            find("input[value='#{review.good_point}']").set('g' * 1501)
            find("input[value='#{review.bad_point}']").set('b' * 1501)
            click_button '更新する'
            expect(page).to have_content '良い点は1500文字以内で入力してください'
            expect(page).to have_content '改善点は1500文字以内で入力してください'
            expect(current_path).to eq novel_path(novel)
          end
        end
      end

      describe '批評削除' do
        let!(:review) {create(:review, user: other_user, novel: novel)}

        it '批評の削除が成功する' do
          visit novel_path(novel)
          page.accept_confirm("削除しますか？") do
            find('.js-delete-review-button').click
          end
          expect(page).not_to have_content review.good_point
          expect(page).not_to have_content review.bad_point
          expect(current_path).to eq novel_path(novel)
        end
      end


      describe '返信投稿' do
        let!(:review) {create(:review, user: other_user, novel: novel)}

        context '入力値が正常' do
          it '返信が成功する' do
            login(user)
            visit novel_path(novel)
            click_link '返信'
            fill_in 'review[comment]', with: 'reply'
            find('.reply-commit').click
            expect(page).to have_content 'reply'
            expect(current_path).to eq novel_path(novel)
          end
        end

        context 'commentが未入力' do
          it '返信が失敗する' do
            login(user)
            visit novel_path(novel)
            visit current_path
            click_link '返信'
            fill_in 'review[comment]', with: ''
            find('.reply-commit').click
            expect(page).to have_content '返信を入力してください'
            expect(current_path).to eq novel_path(novel)
          end
        end

        context '字数超過' do
          it '返信が失敗する' do
            login(user)
            visit novel_path(novel)
            visit current_path
            click_link '返信'
            fill_in 'review[comment]', with: 'a' * 1001
            find('.reply-commit').click
            expect(page).to have_content '返信は1000文字以内で入力してください'
            expect(current_path).to eq novel_path(novel)
          end
        end
      end

      describe '返信編集' do
        let!(:review) {create(:review, user: other_user, novel: novel)}
        let!(:reply) { create(:review, parent_id: review.id, novel: novel, user: user) }

        context '入力値が正常' do
          it '更新が成功する' do
            login(user)
            visit novel_path(novel)
            find('.js-edit-reply-button').click
            fill_in 'review[comment]', with: 'update-reply'
            find('.reply-commit').click
            expect(page).to have_content 'update-reply'
            expect(current_path).to eq novel_path(novel)
          end
        end

        context 'commentが未入力' do
          it '返信が失敗する' do
            login(user)
            visit novel_path(novel)
            find('.js-edit-reply-button').click
            find("input[value='#{reply.comment}']").set('')
            find('.reply-commit').click
            expect(page).to have_content '返信を入力してください'
            expect(current_path).to eq novel_path(novel)
          end
        end

        context '字数超過' do
          it '返信が失敗する' do
            login(user)
            visit novel_path(novel)
            find('.js-edit-reply-button').click
            find("input[value='#{reply.comment}']").set('r' * 1001)
            find('.reply-commit').click
            expect(page).to have_content '返信は1000文字以内で入力してください'
            expect(current_path).to eq novel_path(novel)
          end
        end
      end

      describe '返信削除' do
        let!(:review) {create(:review, user: other_user, novel: novel)}
        let!(:reply) { create(:review, parent_id: review.id, novel: novel, user: user) }

        it '返信の削除が成功する' do
          login(user)
          visit novel_path(novel)
          page.accept_confirm("削除しますか？") do
            find('.js-delete-reply-button').click
          end
          expect(page).not_to have_content reply.comment
          expect(current_path).to eq novel_path(novel)
        end
      end
  end
end
