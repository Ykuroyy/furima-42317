# db/migrate/20250606065010_create_items.rb
class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string  :name
      t.text    :description
      t.integer :category_id
      t.integer :condition_id
      t.integer :shipping_fee_status_id
      t.integer :prefecture_id
      t.integer :scheduled_delivery_id
      t.integer :price

      t.timestamps
    end
  end
end
