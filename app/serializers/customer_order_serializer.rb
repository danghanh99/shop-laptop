class CustomerOrderSerializer < ActiveModel::Serializer
  attributes :id, :status, :subtotal, :user_name, :phone, :address
  has_many :order_items
end
