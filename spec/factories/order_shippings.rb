FactoryBot.define do
  factory :order_shipping do
    postal_code      { '123-4567' }
    prefecture_id    { 2 }
    city             { '広島市中区' }
    street_address   { '本通1-2-3' }
    building         { 'マンション広島101' }
    phone_number     { '09012345678' }
    token            { 'tok_abcdefghijk00000000000000000' }
    # user_id と item_id は外から渡す（FactoryBotでは定義しない）
  end
end
