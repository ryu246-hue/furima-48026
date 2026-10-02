require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '新規登録できる場合' do
      it 'すべての項目が正しく入力されていれば登録できる' do
        expect(@user).to be_valid
      end

      it 'passwordが半角英数字混合であれば登録できる' do
        @user.password = 'abc123'

        @user.password_confirmation = 'abc123'

        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''

        @user.valid?

        expect(@user.errors.full_messages).to include(
          "Nickname can't be blank"
        )
      end

      it 'emailが空では登録できない' do
        @user.email = ''

        @user.valid?

        expect(@user.errors.full_messages).to include(
          "Email can't be blank"
        )
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save

        another_user = FactoryBot.build(:user, email: @user.email)

        another_user.valid?

        expect(another_user.errors.full_messages).to include(
          'Email has already been taken'
        )
      end

      it 'emailに@が含まれていない場合は登録できない' do
        @user.email = 'testexample.com'

        @user.valid?

        expect(@user.errors.full_messages).to include(
          'Email is invalid'
        )
      end

      it 'passwordが空では登録できない' do
        @user.password = ''

        @user.password_confirmation = ''

        @user.valid?

        expect(@user.errors.full_messages).to include(
          "Password can't be blank"
        )
      end

      it 'passwordが6文字未満では登録できない' do
        @user.password = 'a1234'

        @user.password_confirmation = 'a1234'

        @user.valid?

        expect(@user.errors.full_messages).to include(
          'Password is too short (minimum is 6 characters)'
        )
      end

      it 'passwordが英字のみでは登録できない' do
        @user.password = 'abcdef'

        @user.password_confirmation = 'abcdef'

        @user.valid?

        expect(@user.errors.full_messages).to include(
          'Password must include both letters and numbers'
        )
      end

      it 'passwordが数字のみでは登録できない' do
        @user.password = '123456'

        @user.password_confirmation = '123456'

        @user.valid?

        expect(@user.errors.full_messages).to include(
          'Password must include both letters and numbers'
        )
      end

      it 'passwordに全角文字が含まれている場合は登録できない' do
        @user.password = 'abc１２３'

        @user.password_confirmation = 'abc１２３'

        @user.valid?

        expect(@user.errors.full_messages).to include(
          'Password must include both letters and numbers'
        )
      end

      it 'passwordとpassword_confirmationが一致しない場合は登録できない' do
        @user.password = 'abc123'

        @user.password_confirmation = 'abc124'

        @user.valid?

        expect(@user.errors.full_messages).to include(
          "Password confirmation doesn't match Password"
        )
      end

      it 'last_nameが空では登録できない' do
        @user.last_name = ''

        @user.valid?

        expect(@user.errors.full_messages).to include(
          "Last name can't be blank"
        )
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''

        @user.valid?

        expect(@user.errors.full_messages).to include(
          "First name can't be blank"
        )
      end

      it 'last_nameが全角でなければ登録できない' do
        @user.last_name = 'yamada'

        @user.valid?

        expect(@user.errors.full_messages).to include(
          'Last name is invalid. Input full-width characters.'
        )
      end

      it 'first_nameが全角でなければ登録できない' do
        @user.first_name = 'taro'

        @user.valid?

        expect(@user.errors.full_messages).to include(
          'First name is invalid. Input full-width characters.'
        )
      end

      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''

        @user.valid?

        expect(@user.errors.full_messages).to include(
          "Last name kana can't be blank"
        )
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''

        @user.valid?

        expect(@user.errors.full_messages).to include(
          "First name kana can't be blank"
        )
      end

      it 'last_name_kanaが全角カタカナでなければ登録できない' do
        @user.last_name_kana = 'やまだ'

        @user.valid?

        expect(@user.errors.full_messages).to include(
          'Last name kana is invalid. Input full-width katakana characters.'
        )
      end

      it 'first_name_kanaが全角カタカナでなければ登録できない' do
        @user.first_name_kana = 'たろう'

        @user.valid?

        expect(@user.errors.full_messages).to include(
          'First name kana is invalid. Input full-width katakana characters.'
        )
      end

      it 'birth_dateが空では登録できない' do
        @user.birth_date = nil

        @user.valid?

        expect(@user.errors.full_messages).to include(
          "Birth date can't be blank"
        )
      end
    end
  end
end
