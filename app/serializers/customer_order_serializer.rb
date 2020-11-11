class CustomerOrderSerializer < ActiveModel::Serializer
  attributes :id, :status, :subtotal
end
