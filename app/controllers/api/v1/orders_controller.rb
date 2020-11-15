class Api::V1::OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy, :cancelled, :done, :approved, :deny]

  def index
    orders = Order.search(params)
    render_collection(orders, OrderSerializer)
  end

  def show
    render_resource @order
  end

  def create
    Order.transaction do
      order = Order.new(order_params)
      order.pending!
      order_item_ids = params[:order_item_ids] if params[:order_item_ids]
      raise(ArgumentError, 'Order must containt items') unless order_item_ids
      order_item_ids.each do |id|
        item = OrderItem.find id
        item.cart_id = nil
        item.order_id = order.id
        item.save!
      end
      render_resource(order, :created)
    end
  end

  # def update
  #   @order.update!(order_params)
  #   render_resource @order
  # end

  # def destroy
  #   @order.destroy
  # end

  def cancel
    @order.cancelled!
    render_resource @order
  end

  def done
    @order.shipped!
    render_resource @order
  end

  def approve
    @order.shipping!
    render_resource @order
  end

  def deny
    @order.denied!
    render_resource @order
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.permit(:subtotal, :user_id, :phone, :user_name, :address)
    end

    def items_params
      params.permit(order_item_ids: [])
    end
end
