class Api::V1::OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy, :cancelled, :done, :approved, :deny]

  # GET /orders
  def index
    orders = Order.search(params)
    render_collection(orders, OrderSerializer)
  end

  # GET /orders/1
  def show
    render json: @order
  end

  # POST /orders
  def create
    @order = Order.new(order_params)

    if @order.save
      render json: @order, status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
  end

  def cancelled
    @order.cancelled!
    render_resource @order
  end

  def done
    @order.shipped!
    render_resource @order
  end

  def approved
    @order.shipping!
    render_resource @order
  end

  def deny
    @order.deny!
    render_resource @order
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def order_params
      params.require(:order).permit(:subtotal, :user_id)
    end
end
