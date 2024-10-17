require 'rails_helper'

RSpec.describe UserOrder, type: :model do
  describe '購入者情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item, user_id: user.id)
      another_user = FactoryBot.create(:user)
      @user_order = FactoryBot.build(:user_order, user_id: another_user.id, item_id: item.id)
      sleep 0.1
    end
    context '有効な場合' do
      it 'すべての情報が正しく入力されている場合、保存できる' do
        expect(@user_order).to be_valid
      end

      it '建物が空でも保存できる' do
        @user_order.building_name = nil
        expect(@user_order).to be_valid
      end
    end

    context '有効ではない場合' do
      it '郵便番号が空では保存できない' do
        @user_order.postal_code = nil
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Postal code can't be blank")
      end

      it '都道府県が空では保存できない' do
        @user_order.prefecture_id = nil
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村が空では保存できない' do
        @user_order.city = nil
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空では保存できない' do
        @user_order.address = nil
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Address can't be blank")
      end

      it '電話番号が空では保存できない' do
        @user_order.phone_number = nil
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が12桁以上では保存できない' do
        @user_order.phone_number = '123456789012'
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include('Phone number is too long (maximum is 11 characters)')
      end

      it '電話番号が11桁以下でも9桁では保存できない' do
        @user_order.phone_number = '1234567890'
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include('Phone number is too short (minimum is 10 characters)')
      end

      it '電話番号にハイフンが含まれていない場合、保存できない' do
        @user_order.phone_number = '09012345678'
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include('Phone number is invalid')
      end

      it 'ユーザーが自身の商品を購入しようとした場合、保存できない' do
        @user_order.user_id = @user_order.item.user_id
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include('User must be different from item owner')
      end

      it 'ユーザーが存在しない場合、保存できない' do
        @user_order.user_id = 'nonexistent_user_id'
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include('User must exist')
      end

      it '商品が存在しない場合、保存できない' do
        @user_order.item_id = 'nonexistent_item_id'
        @user_order.valid?
        expect(@user_order.errors.full_messages).to include('Item must exist')
      end
    end
  end
end