class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :price
  end

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :condition_id
    validates :shipping_fee_status_id
    validates :prefecture_id
    validates :scheduled_delivery_id
  end

  validates :price, presence: true
  validates :price, format: { with: /\A[0-9]+\z/, message: 'is not a number' }
  validates :price, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 300,
    less_than_or_equal_to: 9_999_999
  }

  # validates :sales_status_id, numericality: { other_than: 1, message: "can't be blank" }

  before_validation :strip_price_whitespace

  private

  def strip_price_whitespace
    self.price = price.to_s.gsub(/[[:space:]]/, '').to_i if price.present?
  end
end
