require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item, user: user)

    @order_address = OrderAddress.new(
      user_id: user.id,
      item_id: item.id,
      postal_code: '123-4567',
      prefecture_id: 2,
      city: '横浜市緑区',
      addresses: '青山1-1-1',
      building: '柳ビル103',
      phone_number: '09012345678',
      token: 'tok_test'
    )
  end

  describe '商品購入情報の保存' do
    context '購入できる場合' do
      it 'すべての情報が正しく入力されていれば保存できる' do
        expect(@order_address).to be_valid
      end

      it '建物名が空でも保存できる' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end

      it '電話番号が10桁でも保存できる' do
        @order_address.phone_number = '0312345678'
        expect(@order_address).to be_valid
      end
    end

    context '購入できない場合' do
      it '郵便番号が空では保存できない' do
        @order_address.postal_code = ''
        expect(@order_address).to be_invalid
      end

      it '郵便番号にハイフンがなければ保存できない' do
        @order_address.postal_code = '1234567'
        expect(@order_address).to be_invalid
      end

      it '都道府県が未選択では保存できない' do
        @order_address.prefecture_id = 1
        expect(@order_address).to be_invalid
      end

      it '市区町村が空では保存できない' do
        @order_address.city = ''
        expect(@order_address).to be_invalid
      end

      it '番地が空では保存できない' do
        @order_address.addresses = ''
        expect(@order_address).to be_invalid
      end

      it '電話番号が空では保存できない' do
        @order_address.phone_number = ''
        expect(@order_address).to be_invalid
      end

      it '電話番号が9桁以下では保存できない' do
        @order_address.phone_number = '090123456'
        expect(@order_address).to be_invalid
      end

      it '電話番号が12桁以上では保存できない' do
        @order_address.phone_number = '090123456789'
        expect(@order_address).to be_invalid
      end

      it '電話番号にハイフンがあると保存できない' do
        @order_address.phone_number = '090-1234-5678'
        expect(@order_address).to be_invalid
      end

      it 'トークンが空では保存できない' do
        @order_address.token = ''
        expect(@order_address).to be_invalid
      end

      it 'ユーザーIDが空では保存できない' do
        @order_address.user_id = nil
        expect(@order_address).to be_invalid
      end

      it '商品IDが空では保存できない' do
        @order_address.item_id = nil
        expect(@order_address).to be_invalid
      end
    end
  end
end
