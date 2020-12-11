class OrderItemSerializer < ActiveModel::Serializer
  attributes :id, :product_name, :unit_price, :quantity, :cart_id, :order_id, :product_id, :picture
  has_one :product
end
