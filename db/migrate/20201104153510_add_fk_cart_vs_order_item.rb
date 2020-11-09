class AddFkCartVsOrderItem < ActiveRecord::Migration[6.0]
  def change
    add_reference :carts, :order_items, index: true, null: true
  end
end
