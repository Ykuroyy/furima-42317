FactoryBot.define do
  factory :order_shipping do
    postal_code      { '123-4567' }
    prefecture_id    { 2 } # 「--」以外のid
    city             { '広島市中区' }
    street_address   { '本通1-2-3' }
    building         { 'マンション広島101' }
    phone_number     { '09012345678' }
    token            { 'tok_abcdefghijk00000000000000000' } # テスト用ダミートークン
    user_id          { 1 }
    item_id          { 1 }

    # 動的に関連user/itemを生成してIDを代入する
    after(:build) do |order_shipping|
      order_shipping.user_id = FactoryBot.create(:user).id
      order_shipping.item_id = FactoryBot.create(:item).id
    end
  end
end
