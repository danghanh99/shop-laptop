class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone, :address
  has_one :cart
end
