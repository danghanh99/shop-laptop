class Api::V1::Customers::OrdersController < ApplicationController
  def customer_index
    user = User.find(params[:id])
    orders = Order.customer_search(user.orders, params)
    render_collection(orders, CustomerOrderSerializer)
    rescue ActiveRecord::StatementInvalid => e
      render_error('Invalid Datestyle', :unprocessable_entity)
  end
end
