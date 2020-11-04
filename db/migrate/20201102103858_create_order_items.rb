class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.integer :unit_price
      t.integer :quantity
      t.references :cart, null: true, foreign_key: true
      t.references :order, null: true, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
