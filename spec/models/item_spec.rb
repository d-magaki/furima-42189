require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品の出品' do
    context '出品できる場合' do
      it '全ての項目が正しく入力されていれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '出品できない場合' do
      it '商品名が空では出品できない' do
        @item.name = ''
        expect(@item).not_to be_valid
      end

      it '商品の説明が空では出品できない' do
        @item.description = ''
        expect(@item).not_to be_valid
      end

      it 'カテゴリーが未選択では出品できない' do
        @item.category_id = 0
        expect(@item).not_to be_valid
      end

      it '商品の状態が未選択では出品できない' do
        @item.condition_id = 0
        expect(@item).not_to be_valid
      end

      it '配送料の負担が未選択では出品できない' do
        @item.shipping_fee_id = 0
        expect(@item).not_to be_valid
      end

      it '発送元の地域が未選択では出品できない' do
        @item.prefecture_id = 0
        expect(@item).not_to be_valid
      end

      it '発送までの日数が未選択では出品できない' do
        @item.shipping_day_id = 0
        expect(@item).not_to be_valid
      end

      it '価格が空では出品できない' do
        @item.price = nil
        expect(@item).not_to be_valid
      end

      it '価格が300円未満では出品できない' do
        @item.price = 299
        expect(@item).not_to be_valid
      end

      it '価格が9,999,999円を超えると出品できない' do
        @item.price = 10_000_000
        expect(@item).not_to be_valid
      end

      it '価格が半角数字以外では出品できない' do
        @item.price = '１０００'
        expect(@item.valid?).to eq false
        expect(@item.errors.full_messages).to include("Price must be in half-width numbers")
      end

      it '商品画像が空では出品できない' do
        @item.image.purge
        expect(@item).not_to be_valid
      end
    end
  end
end