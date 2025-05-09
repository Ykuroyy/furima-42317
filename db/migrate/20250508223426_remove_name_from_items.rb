class RemoveNameFromItems < ActiveRecord::Migration[7.1]
  def change
    remove_column :items, :name, :string
  end
end
