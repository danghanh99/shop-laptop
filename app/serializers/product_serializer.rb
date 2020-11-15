class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :quantity, :ram, :memory, :picture, :description
  has_one :category
end
