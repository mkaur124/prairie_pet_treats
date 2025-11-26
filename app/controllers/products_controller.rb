class ProductsController < ApplicationController
  def index
    if params[:category].present?
      # Filter products by selected category
      @products = Product.joins(:category)
                         .where(categories: { name: params[:category] })
                         .order(created_at: :desc)
                         .page(params[:page])
                         .per(20)
    else
      # Show all products if no category selected
      @products = Product.order(created_at: :desc)
                         .page(params[:page])
                         .per(20)
    end
  end
end
