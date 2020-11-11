class CustomerOrderSerializer < ActiveModel::Serializer
  attributes :id, :status, :subtotal
  has_many :order_items
end
