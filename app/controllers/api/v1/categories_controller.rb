module Api::V1
  class CategoriesController < ApplicationController
    skip_before_action :authorize_request, only: %i[index show]
    before_action :set_category, only: [:show, :update, :destroy, :add_products]

    def add_products
      products = Product.where(id: params[:product_ids])
      products.update_all(category_id: @category.id)
      render_resource @category
    end

    def index
      categories = Category.all
      categories = paginate(categories)
      render_collection categories
    end

    def show
      render_resource @category
    end

    def create
      category = Category.new(category_params)
      category.save!
      render_resource(category, :created)
    end

    def update
      @category.update!(category_params)
      render_resource @category
    end

    def destroy
      @category.destroy!
    end

    private
      def set_category
        @category = Category.find(params[:id])
      end

      def category_params
        params.permit(:name, :description)
      end
  end
end
