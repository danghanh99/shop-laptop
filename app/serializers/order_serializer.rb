class OrderSerializer < ActiveModel::Serializer
  attributes :id, :status, :subtotal, :user_name, :phone, :address
  has_one :user
  has_many :order_items
end
