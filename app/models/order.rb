class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  enum status: { pending: 'pending', shipping: 'shipping',shipped: 'shipped', cancelled: 'cancelled' }
  validates :subtotal, numericality: { greater_than_or_equal_to: 0 }
end
