class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  validates :image, presence: true
  validates :name, presence: true
  validates :description, presence: true

  validates :category_id, :shipping_fee_status_id,
            :prefecture_id, :scheduled_delivery_id,
            numericality: { other_than: 1, message: "can't be blank" }

  validates :price,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  # validates :sales_status_id, numericality: { other_than: 1, message: "can't be blank" }

  before_validation :strip_price_whitespace

  private

  def strip_price_whitespace
    self.price = price.to_s.gsub(/[[:space:]]/, '').to_i if price.present?
  end
end
