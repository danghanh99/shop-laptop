class Api::V1::ProductsController < ApplicationController
  skip_before_action :authorize_request
  before_action :set_product, only: [:show, :update, :destroy]

  def index
    products = Product.search(params)
    products = paginate(products)
    render_collection products
  end

  def show
    render_resource @product
  end

  def create
    params[:picture] = nil
    product = Product.new(product_params)
    image_src = File.join(Rails.root, "/public/uploads/product/picture/6/macbook_pro.jpg")
    src_file = File.new(image_src)
    product.picture = src_file if params[:picture] == nil
    product.save!
    render_resource(product, :created)
  end

  def update
    @product.update!(product_params)
    render_resource @product
  end

  def destroy
    @product.destroy!
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.permit(:name, :price, :quantity, :ram, :memory, :category_id, :picture, :description)
  end
end