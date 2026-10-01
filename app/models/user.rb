class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname

    validates :last_name

    validates :first_name

    validates :last_name_kana

    validates :first_name_kana

    validates :birth_date
  end

  with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full-width characters.' } do
    validates :last_name

    validates :first_name
  end

  with_options format: { with: /\A[ァ-ヶー]+\z/, message: 'is invalid. Input full-width katakana characters.' } do
    validates :last_name_kana

    validates :first_name_kana
  end

  validates :password,
            format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i,

                      message: 'must include both letters and numbers' },

            allow_nil: true
end
