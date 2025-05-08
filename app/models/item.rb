class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :category

  validates :category_id, numericality: { other_than: 1, message: "can't be blank" }

  has_one_attached :image

  validates :image, presence: true
  validates :title, presence: true
  validates :info, presence: true

  validates :category_id, :sales_status_id, :shipping_fee_status_id,
            :prefecture_id, :scheduled_delivery_id,
            numericality: { other_than: 1, message: "can't be blank" }

  validates :price,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end
