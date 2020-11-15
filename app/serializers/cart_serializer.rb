class CartSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :user
  has_many :order_items
end
