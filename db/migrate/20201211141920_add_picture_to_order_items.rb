class AddPictureToOrderItems < ActiveRecord::Migration[6.0]
  def change
    add_column :order_items, :picture, :string
  end
end
