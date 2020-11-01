class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :quantity, :ram, :memory
  has_one :category
end
