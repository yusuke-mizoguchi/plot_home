require 'rails_helper'

RSpec.describe "AdminUsers", type: :system do
    let(:admin) { create(:user, :admin) }
    let(:reader) { create(:user, :reader) }

    before { login(admin) }

        describe 'ユーザー情報の編集' do
            context '入力値が正常' do
                it 'ユーザー情報の編集' do
                    visit edit_admin_user_path(reader)
                    fill_in 'ペンネーム', with: 'update-name'
                    fill_in 'メールアドレス', with: 'update@example.com'
                    select '書き手', from: 'user_role'
                    fill_in_rich_text_area 'プロフィール', with: 'update_profile'
                    click_button '更新する'
                    expect(page).to have_content 'ユーザーを更新しました'
                    expect(current_path).to eq admin_user_path(reader)
                end
            end

            context '未入力' do
                it 'ユーザーの編集が失敗する' do
                    visit edit_admin_user_path(reader)
                    fill_in 'メールアドレス', with: ''
                    fill_in 'ペンネーム', with: ''
                    fill_in_rich_text_area 'プロフィール', with: 'update_profile'
                    click_button '更新する'
                    expect(page).to have_content 'ユーザーを更新できませんでした'
                    expect(page).to have_content 'ペンネームを入力してください'
                    expect(page).to have_content 'メールアドレスを入力してください'
                    expect(current_path).to eq admin_user_path(reader)
                end
            end

            context '登録済みのメールアドレスを使用' do
                it 'ユーザーの編集が失敗する' do
                    existed_user = create(:user)
                    visit edit_admin_user_path(reader)
                    fill_in 'メールアドレス', with: existed_user.email
                    fill_in 'ペンネーム', with: 'update_name'
                    fill_in_rich_text_area 'プロフィール', with: 'update_profile'
                    click_button '更新する'
                    expect(page).to have_content 'ユーザーを更新できませんでした'
                    expect(page).to have_content 'メールアドレスはすでに存在します'
                    expect(current_path).to eq admin_user_path(reader)
                end
            end

            context 'プロフィール字数超過' do
                it 'ユーザーの編集が失敗する' do
                    visit edit_admin_user_path(reader)
                    fill_in 'メールアドレス', with: 'update@example.com'
                    fill_in 'ペンネーム', with: 'update_name'
                    fill_in_rich_text_area 'プロフィール', with: 'a' * 5001
                    click_button '更新する'
                    expect(page).to have_content 'ユーザーを更新できませんでした'
                    expect(page).to have_content 'プロフィールは5000文字以内で入力してください'
                    expect(current_path).to eq admin_user_path(reader)
                end
            end
        end

        describe 'ユーザー削除' do
            it 'ユーザーの削除が成功する' do
                visit admin_user_path(reader)
                page.accept_confirm("削除しますか？") do
                    click_link '削除'
                end
                expect(page).to have_content 'ユーザーを削除しました'
                expect(current_path).to eq admin_users_path
            end
        end
end
