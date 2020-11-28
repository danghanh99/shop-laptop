class Api::V1::OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy, :cancel, :done, :approve, :deny]

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
    Order.transaction do
      raise(ExceptionHandler::BadRequest, 'Something went wrong when trying to cancel order, status wasnot pending') unless @order.pending?
      @order.cancelled!
      render_resource @order
    end
  end

  def done
    Order.transaction do
      raise(ExceptionHandler::BadRequest, 'Something went wrong when trying to done order, status wasnot shipping') unless @order.shipping?
      @order.shipped!
      render_resource @order
    end
  end

  def approve
    Order.transaction do
      raise(ExceptionHandler::BadRequest, 'Something went wrong when trying to approve order, status wasnot pending') unless @order.pending?
      @order.shipping!
      render_resource @order
    end
  end

  def deny
    Order.transaction do
      raise(ExceptionHandler::BadRequest, 'Something went wrong when trying to deny order, status wasnot pending') unless @order.pending?
      @order.denied!
      render_resource @order
    end
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
