class AddDetailsToItems < ActiveRecord::Migration[7.1]
  def change
    # add_column :items, :name, :string ← これは不要なのでコメントアウト

    # すでにあるものは追加しない
    # add_column :items, :description, :text
    # add_column :items, :category_id, :integer
    # add_column :items, :condition_id, :integer
    # add_column :items, :shipping_fee_status_id, :integer
    # add_column :items, :prefecture_id, :integer
    # add_column :items, :scheduled_delivery_id, :integer
    # add_column :items, :price, :integer

    # これだけ追加（未追加なら）
    add_reference :items, :user, null: false, foreign_key: true
  end
end  # ← これが抜けていると SyntaxError になります
