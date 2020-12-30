class Api::V1::OrderItemsController < ApplicationController
  before_action :set_order_item, only: [:show, :update, :destroy, :update_quantity]

  def index
    order_items = OrderItem.all
    order_items = paginate(order_items)
    render_collection order_items
  end

  def show
    render_resource @order_item
  end

  def create
    cart = Cart.find(order_item_params[:cart_id]) if order_item_params[:cart_id].present?
    order_item = cart.order_items.find_by product_id: order_item_params[:product_id] if cart.present?
    if order_item.present?
      order_item.update! quantity: order_item.quantity + 1
      render_resource order_item
    else
      order_item = OrderItem.create!(order_item_params)
      product = Product.find(order_item.product_id)
      order_item.update! picture: product.picture
      render_resource order_item, :created
    end
  end

  def update
    @order_item.update!(order_item_params)
    render_resource @order_item
  end

  def update_quantity
    @order_item.update!(order_item_update_quantity_params)
    render_resource @order_item
  end

  def destroy
    @order_item.destroy!
  end

  private
    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end

    def order_item_params
      params.permit(:product_name, :unit_price, :quantity, :cart_id, :order_id, :product_id)
    end

    def order_item_update_quantity_params
      params.permit(:quantity)
    end
end
