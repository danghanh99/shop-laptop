class Api::V1::Customers::CartsController < ApplicationController
  def customer_show
    user = User.find(params[:id])
    cart = user.cart
    render_resource(cart)
  end
end
  