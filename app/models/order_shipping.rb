class OrderShipping
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :street_address, :building,
                :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code, presence: { message: "can't be blank" },
                            format: { with: /\A\d{3}-\d{4}\z/, message: 'must be in the format 123-4567' }
    validates :prefecture_id, numericality: { other_than: 1, message: 'must be selected' }
    validates :city, presence: { message: "can't be blank" }
    validates :street_address, presence: { message: "can't be blank" }
    validates :phone_number, presence: { message: "can't be blank" },
                             format: { with: /\A\d{10,11}\z/, message: 'must be 10 or 11 digits without hyphens' }
    validates :user_id, presence: { message: "can't be blank" }
    validates :item_id, presence: { message: "can't be blank" }
    validates :token, presence: { message: "can't be blank" }
  end

  def save
    item = Item.find(item_id)

    order = Order.create(user_id: user_id, item_id: item_id, price: item.price)
    unless order.persisted?
      Rails.logger.error("❌ Order保存に失敗: #{order.errors.full_messages}")
      return false
    end

    shipping = ShippingAddress.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      street_address: street_address,
      building: building,
      phone_number: phone_number,
      order_id: order.id
    )

    unless shipping.persisted?
      Rails.logger.error("❌ ShippingAddress保存に失敗: #{shipping.errors.full_messages}")
      return false
    end

    true
  end
end
