require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user, :writer) }
  let(:other_user) { create(:user, :reader) }

  describe 'ログイン前' do
    describe 'ユーザー新規登録' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの新規登録が成功' do
          visit new_user_path
          fill_in 'ペンネーム', with: 'test_writer'
          fill_in 'メールアドレス', with: 'email@example.com'
          select '書き手', from: 'user_role'
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: 'password'
          page.accept_confirm("利用規約に同意して登録しますか？") do
            click_button 'ユーザー登録'
          end
          expect(page).to have_content 'ユーザー登録が完了しました'
          expect(current_path).to eq login_path
        end
      end

      context 'ペンネームが未入力' do
        it 'ユーザーの新規作成が失敗する' do
          visit new_user_path
          fill_in 'ペンネーム', with: ''
          fill_in 'メールアドレス', with: 'email@example.com'
          select '書き手', from: 'user_role'
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: 'password'
          page.accept_confirm("利用規約に同意して登録しますか？") do
            click_button 'ユーザー登録'
          end
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(page).to have_content "ペンネームを入力してください"
          expect(current_path).to eq users_path
        end
      end

      context 'メールアドレスが未入力' do
        it 'ユーザーの新規作成が失敗する' do
          visit new_user_path
          fill_in 'ペンネーム', with: 'test-writer'
          fill_in 'メールアドレス', with: ''
          select '書き手', from: 'user_role'
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: 'password'
          page.accept_confirm("利用規約に同意して登録しますか？") do
            click_button 'ユーザー登録'
          end
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(page).to have_content "メールアドレスを入力してください"
          expect(current_path).to eq users_path
        end
      end

      context '登録済のメールアドレスを使用' do
        it 'ユーザーの新規作成が失敗する' do
          existed_user = create(:user)
          visit new_user_path
          fill_in 'ペンネーム', with: 'test-writer-2'
          fill_in 'メールアドレス', with: existed_user.email
          select '書き手', from: 'user_role'
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: 'password'
          page.accept_confirm("利用規約に同意して登録しますか？") do
            click_button 'ユーザー登録'
          end
          expect(page).to have_content 'ユーザー登録に失敗しました'
          expect(current_path).to eq users_path
          expect(page).to have_content 'メールアドレスはすでに存在します'
          expect(page).to have_field 'メールアドレス', with: existed_user.email
        end
      end
    end
  end

  describe 'ログイン後' do
    before { login(user) }

      describe 'ユーザー編集' do
        context 'フォームの入力値が正常' do
          it 'ユーザーの編集が成功する' do
            visit edit_user_path(user)
            fill_in 'メールアドレス', with: 'update@example.com'
            fill_in 'ペンネーム', with: 'update_name'
            fill_in_rich_text_area 'プロフィール', with: 'update_profile'
            click_button '更新する'
            expect(page).to have_content 'ユーザーを更新しました'
            expect(current_path).to eq user_path(user)
          end
        end

        context 'メールアドレスが未入力' do
          it 'ユーザーの編集が失敗する' do
            visit edit_user_path(user)
            fill_in 'メールアドレス', with: ''
            fill_in 'ペンネーム', with: 'update_name'
            fill_in_rich_text_area 'プロフィール', with: 'update_profile'
            click_button '更新する'
            expect(page).to have_content 'ユーザーを更新できませんでした'
            expect(page).to have_content 'メールアドレスを入力してください'
            expect(current_path).to eq user_path(user)
          end
        end

        context '登録済みのメールアドレスを使用' do
          it 'ユーザーの編集が失敗する' do
            visit edit_user_path(user)
            fill_in 'メールアドレス', with: other_user.email
            fill_in 'ペンネーム', with: 'update_name'
            fill_in_rich_text_area 'プロフィール', with: 'update_profile'
            click_button '更新する'
            expect(page).to have_content 'ユーザーを更新できませんでした'
            expect(page).to have_content 'メールアドレスはすでに存在します'
            expect(current_path).to eq user_path(user)
          end
        end

        context 'ペンネームが未入力' do
          it 'ユーザーの編集が失敗する' do
            visit edit_user_path(user)
            fill_in 'メールアドレス', with: 'update@example.com'
            fill_in 'ペンネーム', with: ''
            fill_in_rich_text_area 'プロフィール', with: 'update_profile'
            click_button '更新する'
            expect(page).to have_content 'ユーザーを更新できませんでした'
            expect(page).to have_content 'ペンネームを入力してください'
            expect(current_path).to eq user_path(user)
          end
        end

        context 'プロフィール字数超過' do
          it 'ユーザーの編集が失敗する' do
            visit edit_user_path(user)
            fill_in 'メールアドレス', with: 'update@example.com'
            fill_in 'ペンネーム', with: 'update_name'
            fill_in_rich_text_area 'プロフィール', with: 'a' * 5001
            click_button '更新する'
            xpect(page).to have_content 'ユーザーを更新できませんでした'
            expect(page).to have_content 'プロフィールは5000文字以内で入力してください'
            expect(current_path).to eq user_path(user)
          end
        end


        context '他ユーザーの編集ページにアクセス' do
          let!(:other_user) { create(:user, email: "other_user@example.com") }
          it '編集ページへのアクセスが失敗する' do
            visit edit_user_path(other_user)
            expect(current_path).to eq user_path(user)
            expect(page).to have_content '権限がありません'
          end
        end
      end
  end
end
