class Api::V1::StatisticsController < ApplicationController
  def count_users
    user_quantity = User.count
    render json: {
      user_quantity: user_quantity,
    }, status: :ok
  end

  def count_orders
    orders = Order.all
    count_orders = orders.count
    orders = orders.unscoped.group(:status).count.transform_keys { |k| Order.statuses.key(k) }
    orders[:count_orders] = count_orders
    render json: {
      orders: orders,
    }, status: :ok
  end

  def count_revenue
    orders = Order.where status: 'shipped'
    orders = orders.where('extract(year  from created_at) = ?', params[:year]) if params[:year].present?
    orders = orders.where('extract(month from created_at) = ?', params[:month]) if params[:month].present?
    response = Hash.new()
    response[:year] = params[:year] || 0
    response[:month] = params[:month] || 0
    response[:order_quantity] = orders.count || 0
    response[:revenue] = orders.pluck(:subtotal).inject{ |item,sum| sum+= item} || 0
    render json: response, status: :ok
  end
  
end
