class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  enum status: { pending: 'pending', shipping: 'shipping',shipped: 'shipped', cancelled: 'cancelled' }
  validates :status, presence: true, inclusion: { in: %w[pending shipping shipped cancelled] }
  validates :subtotal, numericality: { greater_than_or_equal_to: 0 }

  def self.search(params)
    orders = Order.all
    orders.where({ user_id: params[:id].presence, status: params[:status].presence }.compact)
  end
end
