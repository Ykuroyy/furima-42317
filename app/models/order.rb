class Order < ApplicationRecord
  attr_accessor :token

  belongs_to :user
  belongs_to :item
  has_one :shipping_address

  validates :price, presence: true, numericality: { only_integer: true }
  validates :token, presence: true
end
