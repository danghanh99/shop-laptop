class OrderSerializer < ActiveModel::Serializer
  attributes :id, :status, :subtotal
  has_one :user
end
