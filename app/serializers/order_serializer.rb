class OrderSerializer < ActiveModel::Serializer
  attributes :id, :status, :subtotal, :user_name, :phone, :address, :created_at
  has_one :user
  has_many :order_items
end
