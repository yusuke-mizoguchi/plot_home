require 'rails_helper'

RSpec.describe "Novels", type: :system do
  let(:user) { create(:user) }
  let(:reader) { create(:user, :reader) }
  let(:writer) { create(:user, :writer) }
  let(:novel) { create(:novel) }
  let(:draft) { create(:novel, :love) }

  describe 'ログイン前' do
    describe 'ページ遷移の確認' do
      context '小説投稿にアクセス' do
        it '要ログインの表示が出る' do
          visit new_novel_path
          expect(page).to have_content 'ログインしてください'
          expect(current_path).to eq login_path
        end
      end

      context '小説編集にアクセス' do
        it '要ログインの表示が出る' do
          visit edit_novel_path(novel)
          expect(page).to have_content 'ログインしてください'
          expect(current_path).to eq login_path
        end
      end

      context '公開範囲の確認' do
        it '小説一覧に戻る' do
          visit novel_path(draft)
          expect(page).to have_content '権限がありません'
          expect(current_path).to eq novels_path
        end
      end
    end
  end

  describe 'ログイン後' do
    before { login(user) }

    describe '小説投稿' do
      context 'フォームの入力値が正常' do
        it '小説投稿が成功する' do
          visit new_novel_path
          fill_in 'タイトル', with: 'test-title'
          select 'ハイファンタジー', from: 'novel_genre'
          select '中編', from: 'novel_story_length'
          select '読み手まで', from: 'novel_release'
          fill_in_rich_text_area 'プロット', with: 'test-plot'
          click_button '投稿する'
          expect(page).to have_content '小説を投稿しました'
          expect(current_path).to eq novels_path
        end
      end

      context 'タイトルが空白' do
        it '小説投稿が失敗する' do
          visit new_novel_path
          fill_in 'タイトル', with: ''
          select 'ハイファンタジー', from: 'novel_genre'
          select '中編', from: 'novel_story_length'
          select '読み手まで', from: 'novel_release'
          fill_in_rich_text_area 'プロット', with: 'test-plot'
          click_button '投稿する'
          expect(page).to have_content 'タイトルを入力してください'
          expect(page).to have_content '小説を投稿できませんでした'
          expect(current_path).to eq novels_path
        end
      end

      context 'セレクトボックスが未選択' do
        it '小説投稿が失敗する' do
          visit new_novel_path
          fill_in 'タイトル', with: 'test-title'
          select 'ジャンルを選択', from: 'novel_genre'
          select '文量を選択', from: 'novel_story_length'
          select '公開範囲を選択', from: 'novel_release'
          fill_in_rich_text_area 'プロット', with: 'test-plot'
          click_button '投稿する'
          expect(page).to have_content 'ジャンルを入力してください'
          expect(page).to have_content '文量を入力してください'
          expect(page).to have_content '公開範囲を入力してください'
          expect(page).to have_content '小説を投稿できませんでした'
          expect(current_path).to eq novels_path
        end
      end

      context 'プロットが空白' do
        it '小説投稿が失敗する' do
          visit new_novel_path
          fill_in 'タイトル', with: 'test-title'
          select 'ハイファンタジー', from: 'novel_genre'
          select '中編', from: 'novel_story_length'
          select '読み手まで', from: 'novel_release'
          fill_in_rich_text_area 'プロット', with: ''
          click_button '投稿する'
          expect(page).to have_content 'プロットを入力してください'
          expect(page).to have_content '小説を投稿できませんでした'
          expect(current_path).to eq novels_path
        end
      end

      context 'タイトル字数超過' do
        it '小説投稿が失敗する' do
          visit new_novel_path
          fill_in 'タイトル', with: 'a' * 51
          select 'ハイファンタジー', from: 'novel_genre'
          select '中編', from: 'novel_story_length'
          select '読み手まで', from: 'novel_release'
          fill_in_rich_text_area 'プロット', with: 'test-plot'
          click_button '投稿する'
          expect(page).to have_content 'タイトルは50文字以内で入力してください'
          expect(page).to have_content '小説を投稿できませんでした'
          expect(current_path).to eq novels_path
        end
      end

      context 'プロット字数超過' do
        it '小説投稿が失敗する' do
          visit new_novel_path
          fill_in 'タイトル', with: 'test-title'
          select 'ハイファンタジー', from: 'novel_genre'
          select '中編', from: 'novel_story_length'
          select '読み手まで', from: 'novel_release'
          fill_in_rich_text_area 'プロット', with: 'a' * 5001
          click_button '投稿する'
          expect(page).to have_content 'プロットは5000文字以内で入力してください'
          expect(page).to have_content '小説を投稿できませんでした'
          expect(current_path).to eq novels_path
        end
      end

      context 'タイトル重複' do
        it '小説投稿が失敗する' do
          existed_novel = create(:novel)
          visit new_novel_path
          fill_in 'タイトル', with: existed_novel.title
          select 'ハイファンタジー', from: 'novel_genre'
          select '中編', from: 'novel_story_length'
          select '読み手まで', from: 'novel_release'
          fill_in_rich_text_area 'プロット', with: 'test-plot'
          click_button '投稿する'
          expect(page).to have_content 'タイトルはすでに存在します'
          expect(page).to have_content '小説を投稿できませんでした'
          expect(current_path).to eq novels_path
        end
      end
    end

    describe '小説編集' do
      let!(:novel) { create(:novel, user: user) }

      context 'フォームの入力値が正常' do
        it '小説編集が成功する' do
          visit edit_novel_path(novel)
          fill_in 'タイトル', with: 'update-test-title'
          select 'ホラー', from: 'novel_genre'
          select '短編', from: 'novel_story_length'
          select '公開', from: 'novel_release'
          fill_in_rich_text_area 'プロット', with: 'update-test-plot'
          click_button '更新する'
          expect(page).to have_content '小説を更新しました'
          expect(current_path).to eq novel_path(novel)
        end
      end

      context 'タイトルが空白' do
        it '小説編集が失敗する' do
          visit edit_novel_path(novel)
          fill_in 'タイトル', with: ''
          select 'ホラー', from: 'novel_genre'
          select '短編', from: 'novel_story_length'
          select '公開', from: 'novel_release'
          fill_in_rich_text_area 'プロット', with: 'update-test-plot'
          click_button '更新する'
          expect(page).to have_content '小説を更新できませんでした'
          expect(page).to have_content 'タイトルを入力してください'
          expect(current_path).to eq novel_path(novel)
        end
      end

      context 'セレクトボックスが未選択' do
        it '小説編集が失敗する' do
          visit edit_novel_path(novel)
          fill_in 'タイトル', with: 'update-test-title'
          select 'ジャンルを選択', from: 'novel_genre'
          select '文量を選択', from: 'novel_story_length'
          select '公開範囲を選択', from: 'novel_release'
          fill_in_rich_text_area 'プロット', with: 'update-test-plot'
          click_button '更新する'
          expect(page).to have_content 'ジャンルを入力してください'
          expect(page).to have_content '文量を入力してください'
          expect(page).to have_content '公開範囲を入力してください'
          expect(page).to have_content '小説を更新できませんでした'
          expect(current_path).to eq novel_path(novel)
        end
      end

      context 'プロットが空白' do
        it '小説編集が失敗する' do
          visit edit_novel_path(novel)
          fill_in 'タイトル', with: 'update-test-title'
          select 'ホラー', from: 'novel_genre'
          select '短編', from: 'novel_story_length'
          select '公開', from: 'novel_release'
          fill_in_rich_text_area 'プロット', with: ''
          click_button '更新する'
          expect(page).to have_content 'プロットを入力してください'
          expect(page).to have_content '小説を更新できませんでした'
          expect(current_path).to eq novel_path(novel)
        end
      end

      context 'タイトル字数超過' do
        it '小説投稿が失敗する' do
          visit edit_novel_path(novel)
          fill_in 'タイトル', with: 'a' * 51
          select 'ホラー', from: 'novel_genre'
          select '短編', from: 'novel_story_length'
          select '公開', from: 'novel_release'
          fill_in_rich_text_area 'プロット', with: 'update-test-plot'
          click_button '更新する'
          expect(page).to have_content 'タイトルは50文字以内で入力してください'
          expect(page).to have_content '小説を更新できませんでした'
          expect(current_path).to eq novel_path(novel)
        end
      end

      context 'プロット字数超過' do
        it '小説投稿が失敗する' do
          visit edit_novel_path(novel)
          fill_in 'タイトル', with: 'update-test-title'
          select 'ホラー', from: 'novel_genre'
          select '短編', from: 'novel_story_length'
          select '公開', from: 'novel_release'
          fill_in_rich_text_area 'プロット', with: 'a' * 5001
          click_button '更新する'
          expect(page).to have_content 'プロットは5000文字以内で入力してください'
          expect(page).to have_content '小説を更新できませんでした'
          expect(current_path).to eq novel_path(novel)
        end
      end

      context 'タイトル重複' do
        it '小説投稿が失敗する' do
          existed_novel = create(:novel)
          visit edit_novel_path(novel)
          fill_in 'タイトル', with: existed_novel.title
          select 'ハイファンタジー', from: 'novel_genre'
          select '中編', from: 'novel_story_length'
          select '読み手まで', from: 'novel_release'
          fill_in_rich_text_area 'プロット', with: 'test-plot'
          click_button '更新する'
          expect(page).to have_content 'タイトルはすでに存在します'
          expect(page).to have_content '小説を更新できませんでした'
          expect(current_path).to eq novel_path(novel)
        end
      end

      context '他ユーザーの小説編集ページにアクセス' do
        let!(:other_user) { create(:user, :writer) }
        let!(:other_novel) { create(:novel, :classic, user: other_user)}

        it '編集ページへのアクセスが失敗する' do
          visit edit_novel_path(other_novel)
          expect(current_path).to eq novel_path(other_novel)
          expect(page).to have_content '権限がありません'
        end
      end
    end

    describe '小説削除' do
      let!(:novel) { create(:novel, user: user) }

      it '小説の削除ができる' do
        visit novel_path(novel)
        page.accept_confirm("削除しますか？") do
          find(id: "button-delete-#{novel.id}").click
        end
        expect(page).to have_content '小説を削除しました'
        expect(current_path).to eq novels_path
      end
    end
  end
end
