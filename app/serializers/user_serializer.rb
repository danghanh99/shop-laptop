class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone, :address, :roles
  has_one :cart
end
