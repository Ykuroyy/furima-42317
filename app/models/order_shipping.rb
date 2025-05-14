class OrderShipping
  include ActiveModel::Model

  attr_accessor :postal_code, :prefecture_id, :city, :street_address, :building,
                :phone_number, :user_id, :item_id, :token

  # ✅ バリデーションを分離して明示する
  validates :postal_code, presence: true
  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-)' }

  with_options presence: true do
    validates :city
    validates :street_address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Input only number' }
    validates :token
    validates :user_id
    validates :item_id
  end

  def save
    item = Item.find(item_id)
    order = Order.create(user_id: user_id, item_id: item_id, price: item.price)

    return false unless order.persisted?

    shipping = ShippingAddress.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      street_address: street_address,
      building: building,
      phone_number: phone_number,
      order_id: order.id
    )

    shipping.persisted?
  end
end
