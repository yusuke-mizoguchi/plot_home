class User < ApplicationRecord
  has_many :novels, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_rich_text :profile

  authenticates_with_sorcery!

  validates :password, length: { minimum: 4, maximum: 20 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :profile, length: { maximum: 5000 }

  validates :name, length: { maximum: 30 }, presence: true
  validates :email, uniqueness: true, presence: true
  validates :role, presence: true

  enum role: { reader: 0,  writer: 10}

  def own?(object)
    id == object.user_id
  end
end
