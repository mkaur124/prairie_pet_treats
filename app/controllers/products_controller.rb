class ProductsController < ApplicationController
  def index
    if params[:category].present?
      # Filter products by selected category
      @products = Product.joins(:category)
                         .where(categories: { name: params[:category] })
                         .order(created_at: :desc)
                         .page(params[:page])
                         .per(12)
    else
      # Show all products if no category selected
      @products = Product.order(created_at: :desc)
                         .page(params[:page])
                         .per(12)
    end
  end
end
