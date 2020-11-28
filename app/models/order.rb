class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  enum status: { pending: 'pending', shipping: 'shipping',shipped: 'shipped', cancelled: 'cancelled', denied: 'denied' }
  validates :status, presence: true, inclusion: { in: %w[pending shipping shipped cancelled denied] }
  validates :subtotal, numericality: { greater_than_or_equal_to: 0 }
  validates :user_name, presence: true, length: { maximum: 60 } 
  validates :address, presence: true
  VALID_PHONE_NUMBER_REGEX = /\d[0-9]\)*\z/.freeze
  validates :phone, presence: true, allow_nil: true, length: { maximum: 25 },
                            format: { with: VALID_PHONE_NUMBER_REGEX }
  scope :order_from, ->(from) { where('created_at >= ?', from) if from }
  scope :order_to, ->(to) { where('created_at <= ?', to) if to }

  def self.search(params)
    orders = Order.all
    orders = Order.includes(:user, :order_items)
    orders = orders.where({ user_id: params[:id].presence, status: params[:status].presence }.compact)
    orders = orders.order_to(params[:order_to]).order_from(params[:order_from])
    orders = orders.where(user_id: User.user_name(params[:search]).pluck(:id)) if params[:search].present?
    orders
  end

  def self.customer_search(orders, params)
    orders = orders.where(status: params[:status]) if params[:status].present?
    orders = orders.where('created_at >= ?', params[:order_from]) if params[:order_from].present?
    
    orders = orders.where('created_at <= ?', params[:order_to]) if params[:order_to].present?
    orders
  end
end
