FactoryBot.define do
  factory :order_shipping do
    postal_code      { '123-4567' }
    prefecture_id    { 2 }
    city             { 'Hiroshima' }
    street_address   { '1-2-3 Hondori' }
    building         { 'Hiroshima Mansion 101' }
    phone_number     { '09012345678' }
    token            { 'tok_abcdefghijk00000000000000000' }

    after(:build) do |order_shipping|
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      order_shipping.user_id = user.id
      order_shipping.item_id = item.id
    end
  end
end
