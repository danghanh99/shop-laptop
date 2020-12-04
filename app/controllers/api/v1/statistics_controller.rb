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

  # def count_revenue
  #   user_quantity = User.count
  #   render json: {
  #     user_quantity: user_quantity,
  #   }, status: :ok
  # end

  
end
