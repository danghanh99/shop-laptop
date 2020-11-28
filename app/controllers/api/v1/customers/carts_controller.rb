class Api::V1::Customers::CartsController < ApplicationController
  def customer_index
    user = User.find(params[:id])
    cart = user.cart
    render_resource(cart)
  end
end
  