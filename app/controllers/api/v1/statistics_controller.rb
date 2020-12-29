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
    response = count_revenue_in_year(params[:year]) if params[:year].present?
    render json: response, status: :ok
  end

  def count_revenue_in_year(year)
    response = {1 =>{}, 2=>{}, 3=> {}, 4=>{}, 5 =>{}, 6=>{}, 7=> {}, 8=>{}, 9 =>{}, 10=>{}, 11=> {}, 12=>{} }
    orders = Order.where status: 'shipped'
    orders = orders.where('extract(year  from created_at) = ?', year) if year
    response.each do |key, value|
      orders_in_month = orders.where('extract(month from created_at) = ?', key)
      response[key][:order_quantity] = orders_in_month.count || 0
      response[key][:product_quantity] = count_products(orders_in_month) || 0
      response[key][:revenue] = orders_in_month.pluck(:subtotal).inject{ |item,sum| sum+= item} || 0
    end
    response
  end

  def count_products(orders_in_month)
    count = 0
    orders_in_month.each do |order|
      order.order_items.each do |item|
        count += item.quantity
      end
    end
    count
  end
end
