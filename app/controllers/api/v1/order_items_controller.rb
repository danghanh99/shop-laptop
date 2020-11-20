class Api::V1::OrderItemsController < ApplicationController
  before_action :set_order_item, only: [:show, :update, :destroy, :update_quantity]

  def index
    order_items = OrderItem.all
    render_collection order_items
  end

  def show
    render_resource @order_item
  end

  def create
    order_item = OrderItem.new(order_item_params)
    order_item.save!
    render_resource order_item, :created
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
