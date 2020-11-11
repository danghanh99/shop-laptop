class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  enum status: { pending: 'pending', shipping: 'shipping',shipped: 'shipped', cancelled: 'cancelled' }
  validates :status, presence: true, inclusion: { in: %w[pending shipping shipped cancelled] }
  validates :subtotal, numericality: { greater_than_or_equal_to: 0 }
  scope :order_to, ->(to) { where('created_at <= ?', to) if to }
  scope :order_from, ->(from) { where('created_at >= ?', from) if from }

  def self.search(params)
    orders = Order.includes(:user, :order_items)
    orders = orders.where({ user_id: params[:id].presence, status: params[:status].presence }.compact)
    orders = orders.order_to(params[:order_to]).order_from(params[:order_from])
    orders = orders.where(user_id: User.user_name(params[:search]).pluck(:id)) if params[:search].present?
    orders
  end
end
