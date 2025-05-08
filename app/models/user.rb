class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :orders
  # ニックネーム
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
  # 氏名（全角漢字・ひらがな・カタカナ）
  validates :last_name, presence: { message: "can't be blank" },
                        format: { with: /\A[ぁ-んァ-ン一-龥々ー]+\z/, message: 'is invalid. Input full-width characters' }
  validates :first_name, presence: { message: "can't be blank" },
                         format: { with: /\A[ぁ-んァ-ン一-龥々ー]+\z/, message: 'is invalid. Input full-width characters' }

  # カナ（全角カタカナ）
  validates :last_name_kana,  presence: { message: "can't be blank" },
                              format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input full-width katakana characters' }
  validates :first_name_kana, presence: { message: "can't be blank" },
                              format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input full-width katakana characters' }

  # 生年月日
  validates :birth_date, presence: { message: "can't be blank" }

  private

  # パスワードのバリデーションを必要な時のみ行う（Deviseの仕様に準拠）
  def password_required?
    new_record? || password.present? || password_confirmation.present?
  end
end
