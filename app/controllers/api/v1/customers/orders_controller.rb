class Api::V1::Customers::OrdersController < ApplicationController
  def index
    orders = Order.search(params)
    render_collection(orders, CustomerOrderSerializer)
  end
end
