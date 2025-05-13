require 'rails_helper'

RSpec.describe OrderShipping, type: :model do
  describe 'Purchase data saving' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_shipping = FactoryBot.build(:order_shipping, user_id: user.id, item_id: item.id)
    end

    context 'When content is valid' do
      it 'is valid with all values filled in' do
        expect(@order_shipping).to be_valid
      end

      it 'is valid without a building' do
        @order_shipping.building = ''
        expect(@order_shipping).to be_valid
      end
    end

    context 'When content is invalid' do
      it 'is invalid without a postal_code' do
        @order_shipping.postal_code = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'is invalid if postal_code does not include hyphen' do
        @order_shipping.postal_code = '1234567'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Postal code must be in the format 123-4567')
      end

      it 'is invalid if postal_code is full-width' do
        @order_shipping.postal_code = '１２３-４５６７'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Postal code must be in the format 123-4567')
      end

      it 'is invalid if prefecture_id is 1' do
        @order_shipping.prefecture_id = 1
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Prefecture must be selected')
      end

      it 'is invalid without a city' do
        @order_shipping.city = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("City can't be blank")
      end

      it 'is invalid without a street_address' do
        @order_shipping.street_address = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Street address can't be blank")
      end

      it 'is invalid without a phone_number' do
        @order_shipping.phone_number = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'is invalid if phone_number is less than 10 digits' do
        @order_shipping.phone_number = '090123456'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Phone number must be 10 or 11 digits without hyphens')
      end

      it 'is invalid if phone_number is more than 11 digits' do
        @order_shipping.phone_number = '090123456789'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Phone number must be 10 or 11 digits without hyphens')
      end

      it 'is invalid if phone_number contains hyphens' do
        @order_shipping.phone_number = '090-1234-5678'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Phone number must be 10 or 11 digits without hyphens')
      end

      it 'is invalid without a token' do
        @order_shipping.token = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Token can't be blank")
      end

      it 'is invalid without a user_id' do
        @order_shipping.user_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("User can't be blank")
      end

      it 'is invalid without an item_id' do
        @order_shipping.item_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
