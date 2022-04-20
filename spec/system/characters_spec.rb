require 'rails_helper'

RSpec.describe "Characters", type: :system do
  let!(:novel) { create(:novel) }

  describe 'ログイン後' do
    before { login(novel.user) }

      describe 'キャラクター追加' do
        context 'フォームの入力値が正常' do
          it 'キャラクターの追加が成功する' do
            visit edit_novel_path(novel)
            find('.add_fields').click
            fill_in '役割', with: 'test_role'
            fill_in_rich_text_area '設定', with: 'test_text'
            execute_script('window.scrollBy(0,10000)')
            find(:xpath, '//*[@id="novel-post"]').hover.click
            expect(page).to have_content('小説を更新しました')
            expect(current_path).to eq novel_path(novel)
          end
        end

        context '字数超過' do
          it 'キャラクターの追加が失敗する' do
            visit edit_novel_path(novel)
            find('.add_fields').click
            fill_in '役割', with: 'a' * 21
            fill_in_rich_text_area '設定', with: 'a' * 3001
            execute_script('window.scrollBy(0,10000)')
            find(:xpath, '//*[@id="novel-post"]').hover.click
            expect(page).to have_content('役割は20文字以内で入力してください')
            expect(page).to have_content('設定は3000文字以内で入力してください')
            expect(current_path).to eq novel_path(novel)
          end
        end
      end

      describe 'キャラクター削除' do
        let!(:character) { create(:character, novel: novel) }

        it 'キャラクター削除' do
          visit edit_novel_path(novel)
          execute_script('window.scroll(0,10000)')
          page.accept_confirm("削除しますか？") do
            find(id: 'delete-character').click
          end
          expect(page).not_to have_content character.character_role
          expect(page).not_to have_content character.character_text
          expect(current_path).to eq novel_path(novel)
        end
      end
  end
end
