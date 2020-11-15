class OrderItemSerializer < ActiveModel::Serializer
  attributes :id, :unit_price, :quantity, :cart_id, :order_id
  has_one :product
end
