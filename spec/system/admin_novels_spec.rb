require 'rails_helper'

RSpec.describe "AdminNovels", type: :system do
    let(:admin) { create(:user, :admin) }
    let!(:writer) { create(:user, :writer) }
    let(:novel) { create(:novel, user: writer) }

    before { login(admin) }

        describe '小説編集' do
            context 'フォームの入力値が正常' do
                it '小説編集が成功する' do
                    visit edit_admin_novels_path(novel)
                    fill_in 'タイトル', with: 'update-test-title'
                    select 'ホラー', from: 'novel_genre'
                    select '短編', from: 'novel_story_length'
                    select '公開', from: 'novel_release'
                    fill_in_rich_text_area 'プロット', with: 'update-test-plot'
                    click_button '更新する'
                    expect(page).to have_content '小説を更新しました'
                    expect(current_path).to eq admin_novel_path(novel)
                end
            end

            context '空白' do
                it '小説編集が失敗する' do
                    visit edit_admin_novels_path(novel)
                    fill_in 'タイトル', with: ''
                    select 'ジャンルを選択', from: 'novel_genre'
                    select '文量を選択', from: 'novel_story_length'
                    select '公開範囲を選択', from: 'novel_release'
                    fill_in_rich_text_area 'プロット', with: 'u'
                    click_button '更新する'
                    expect(page).to have_content 'タイトルを入力してください'
                    expect(page).to have_content 'ジャンルを入力してください'
                    expect(page).to have_content '文量を入力してください'
                    expect(page).to have_content '公開範囲を入力してください'
                    expect(page).to have_content 'プロットを入力してください'
                    expect(page).to have_content '小説を更新できませんでした'
                    expect(current_path).to eq admin_novel_path(novel)
                end
            end

            context '字数超過' do
                it '小説編種が失敗する' do
                    visit edit_admin_novels_path(novel)
                    fill_in 'タイトル', with: 'a' * 51
                    select 'ホラー', from: 'novel_genre'
                    select '短編', from: 'novel_story_length'
                    select '公開', from: 'novel_release'
                    fill_in_rich_text_area 'プロット', with: 'a' * 5001
                    click_button '更新する'
                    expect(page).to have_content 'タイトルは50文字以内で入力してください'
                    expect(page).to have_content 'プロットは5000文字以内で入力してください'
                    expect(page).to have_content '小説を更新できませんでした'
                    expect(current_path).to eq admin_novel_path(novel)
                end
            end

            context 'タイトル重複' do
                it '小説編集が失敗する' do
                    visit edit_admin_novels_path(novel)
                    existed_novel = create(:novel)
                    fill_in 'タイトル', with: existed_novel.title
                    select 'ハイファンタジー', from: 'novel_genre'
                    select '中編', from: 'novel_story_length'
                    select '読み手まで', from: 'novel_release'
                    fill_in_rich_text_area 'プロット', with: 'test-plot'
                    click_button '更新する'
                    expect(page).to have_content 'タイトルはすでに存在します'
                    expect(page).to have_content '小説を更新できませんでした'
                    expect(current_path).to eq admin_novel_path(novel)
                end
            end
        end

        describe '小説削除' do
            let!(:novel) { create(:novel, user: writer) }

            it '小説の削除ができる' do
                visit admin_novel_path(novel)
                page.accept_confirm("削除しますか？") do
                    click_button '削除'
                end
                expect(page).to have_content '小説を削除しました'
                expect(current_path).to eq admin_novels_path
            end
        end
end