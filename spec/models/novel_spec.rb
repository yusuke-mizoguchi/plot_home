require 'rails_helper'

RSpec.describe Novel, type: :model do
  describe 'バリデーション' do
    it 'attributes' do
      novel = build(:novel)
      expect(novel).to be_valid
      expect(novel.errors).to be_empty
    end

    it 'title空白' do
      novel_without_title = build(:novel, title: "")
      expect(novel_without_title).to be_invalid
      expect(novel_without_title.errors[:title]).to eq ["を入力してください"]
    end

    it 'genre空白' do
      novel_without_genre = build(:novel, genre: nil)
      expect(novel_without_genre).to be_invalid
      expect(novel_without_genre.errors[:genre]).to eq ["を入力してください"]
    end

    it 'story_length空白' do
      novel_without_story_length = build(:novel, story_length: nil)
      expect(novel_without_story_length).to be_invalid
      expect(novel_without_story_length.errors[:story_length]).to eq ["を入力してください"]
    end

    it 'release空白' do
      novel_without_release = build(:novel, release: nil)
      expect(novel_without_release).to be_invalid
      expect(novel_without_release.errors[:release]).to eq ["を入力してください"]
    end

    it 'plot空白' do
      novel_without_plot = build(:novel, plot: "")
      expect(novel_without_plot).to be_invalid
      expect(novel_without_plot.errors[:plot]).to eq ["を入力してください"]
    end

    it 'title文字数超過' do
      novel_over_title = build(:novel, title: "a" * 51)
      expect(novel_over_title).to be_invalid
      expect(novel_over_title.errors[:title]).to eq ["は50文字以内で入力してください"]
    end

    it 'title重複' do
      novel = create(:novel)
      novel_with_duplicated_title = build(:novel, title: novel.title)
      expect(novel_with_duplicated_title).to be_invalid
      expect(novel_with_duplicated_title.errors[:title]).to eq ["はすでに存在します"]
    end

    it '別のtitle' do
      novel = create(:novel)
      novel_with_anoher_title = build(:novel, title: 'another_title')
      expect(novel_with_anoher_title).to be_valid
      expect(novel_with_anoher_title.errors).to be_empty
    end
  end
end
