class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :quantity, :ram, :memory, :picture
  has_one :category
end
