require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it 'attributes' do
      user = build(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end

    it 'name空白' do
      user_without_name = build(:user, name: nil)
      expect(user_without_name).to be_invalid
      expect(user_without_name.errors[:name]).to eq ["を入力してください"]
    end

    it 'email空白' do
      user_without_email = build(:user, email: nil)
      expect(user_without_email).to be_invalid
      expect(user_without_email.errors[:email]).to eq ["を入力してください"]
    end

    it 'password空白' do
      user_without_password = build(:user, password: nil)
      expect(user_without_password).to be_invalid
      expect(user_without_password.errors[:password]).to eq ["は4文字以上で入力してください"]
    end

    it 'password_confirmation空白' do
      user_without_password_confimation = build(:user, password_confirmation: nil)
      expect(user_without_password_confimation).to be_invalid
      expect(user_without_password_confimation.errors[:password_confirmation]).to eq ["を入力してください"]
    end

    it 'name文字数超過' do
      user_over_name = build(:user, name: "a" * 31)
      expect(user_over_name).to be_invalid
      expect(user_over_name.errors[:name]).to eq ["は30文字以内で入力してください"]
    end

    it 'email重複' do
      user = create(:user)
      user_with_duplicated_email = build(:user, email: user.email)
      expect(user_with_duplicated_email).to be_invalid
      expect(user_with_duplicated_email.errors[:email]).to eq ["はすでに存在します"]
    end

    it '別のemail' do
      user = create(:user)
      user_with_anoher_email = build(:user, email: 'another_email@example.com')
      expect(user_with_anoher_email).to be_valid
      expect(user_with_anoher_email.errors).to be_empty
    end

    it 'password3文字以下' do
      user_few_password = build(:user, password: "aaa")
      expect(user_few_password).to be_invalid
      expect(user_few_password.errors[:password]).to eq ["は4文字以上で入力してください"]
    end
  end
end
