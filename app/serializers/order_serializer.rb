class OrderSerializer < ActiveModel::Serializer
  attributes :id, :status, :subtotal
  has_one :user
  has_many :order_items
end
