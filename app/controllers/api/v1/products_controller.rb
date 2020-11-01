module Api::V1
  class ProductsController < ApplicationController
    before_action :set_product, only: [:show, :update, :destroy]

    def index
      products = Product.all
      render_resources(products, :ok, ProductSerializer)
    end

    def show
      render_resource @product
    end

    def create
      product = Product.new(product_params)
      product.save!
      render_resource(product, :created)
    end

    def update
      @product.update!(product_params)
      render_resource @product
    end

    def destroy
      @product.destroy
    end

    private
      def set_product
        @product = Product.find(params[:id])
      end

      def product_params
        params.permit(:name, :price, :quantity, :ram, :memory, :category_id)
      end
  end
end