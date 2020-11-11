class Api::V1::Customers::CartsController < ApplicationController
  def index
    cart = Cart.find(params[:id]).order_items
    render_resource(cart)
  end
end
  