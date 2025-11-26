class ProductsController < ApplicationController
  # Show list of products, optionally filtered by category
  def index
    if params[:category].present?
      @products = Product.joins(:category)
                         .where(categories: { name: params[:category] })
                         .order(created_at: :desc)
                         .page(params[:page])
                         .per(20)
    else
      @products = Product.order(created_at: :desc)
                         .page(params[:page])
                         .per(20)
    end
  end

  # Show a single product
  def show
    @product = Product.find_by(id: params[:id])
    unless @product
      redirect_to products_path, alert: "Product not found"
    end
  end
end
