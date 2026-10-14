require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品を出品できる場合' do
      it '必要な情報がすべて入力されていれば保存できる' do
        expect(@item).to be_valid
      end
    end

    context '商品を出品できない場合' do
      it '商品画像がないと保存できない' do
        @item.image = nil
        expect(@item).to be_invalid
      end

      it '商品名が空では保存できない' do
        @item.name = ''
        expect(@item).to be_invalid
      end

      it '商品の説明が空では保存できない' do
        @item.description = ''
        expect(@item).to be_invalid
      end

      it 'カテゴリーが未選択では保存できない' do
        @item.category_id = 1
        expect(@item).to be_invalid
      end

      it '商品の状態が未選択では保存できない' do
        @item.condition_id = 1
        expect(@item).to be_invalid
      end

      it '配送料の負担が未選択では保存できない' do
        @item.shipping_charge_id = 1
        expect(@item).to be_invalid
      end

      it '発送元の地域が未選択では保存できない' do
        @item.prefecture_id = 1
        expect(@item).to be_invalid
      end

      it '発送までの日数が未選択では保存できない' do
        @item.shipping_day_id = 1
        expect(@item).to be_invalid
      end

      it '価格が300円未満では保存できない' do
        @item.price = 299
        expect(@item).to be_invalid
      end

      it '価格が9,999,999円を超えると保存できない' do
        @item.price = 10_000_000
        expect(@item).to be_invalid
      end

      it '価格が全角数字では保存できない' do
        @item.price = '１０００'
        expect(@item).to be_invalid
      end

      it '価格が空では保存できない' do
        @item.price = nil
        expect(@item).to be_invalid
      end

      it '価格に文字が含まれていると保存できない' do
        @item.price = '1000円'
        expect(@item).to be_invalid
      end

      it 'ユーザーが紐付いていないと保存できない' do
        @item.user = nil
        expect(@item).to be_invalid
      end
    end
  end
end
