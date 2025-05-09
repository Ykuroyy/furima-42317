class AddShippingFeeStatusIdToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :shipping_fee_status_id, :integer
  end
end
