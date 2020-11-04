class OrderItemSerializer < ActiveModel::Serializer
  attributes :id, :unit_price, :quantity
  has_one :product
end
