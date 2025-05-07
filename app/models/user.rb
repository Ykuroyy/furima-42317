class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :orders

  validates :nickname, presence: { message: "can't be blank" }

  # メールアドレス
  validates :email, presence: { message: "can't be blank" }
  validates :email, uniqueness: { message: 'has already been taken' }
  validates :email, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "is invalid. Include '@'" }

  # パスワード
  validates :password, presence: { message: "can't be blank" }
  validates :password, length: { minimum: 6, message: 'is too short (minimum is 6 characters)' }
  validates :password, format: {
    with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/,
    message: 'is invalid. Include both letters and numbers'
  }

  validates :last_name,  presence: { message: "can't be blank" }
  validates :first_name, presence: { message: "can't be blank" }
  validates :last_name,  format: { with: /\A[ぁ-んァ-ン一-龥々ー]+\z/, message: 'is invalid. Input full-width characters' }
  validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥々ー]+\z/, message: 'is invalid. Input full-width characters' }

  validates :last_name_kana,  presence: { message: "can't be blank" }
  validates :first_name_kana, presence: { message: "can't be blank" }
  validates :last_name_kana,  format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input full-width katakana characters' }
  validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input full-width katakana characters' }

  validates :birth_date, presence: { message: "can't be blank" }
end
