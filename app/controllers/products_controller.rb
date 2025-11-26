class ProductsController < ApplicationController

  # Show list of products, with optional filters
  def index

    # Filter: New products (created in last 3 days)
    if params[:filter] == "new"
      @products = Product.where("created_at >= ?", 3.days.ago)
                         .order(created_at: :desc)
                         .page(params[:page])
                         .per(20)

    # Filter: Recently updated (updated in last 3 days, but not new)
    elsif params[:filter] == "updated"
      @products = Product.where("updated_at >= ?", 3.days.ago)
                         .where("created_at < ?", 3.days.ago) # EXCLUDE new products
                         .order(updated_at: :desc)
                         .page(params[:page])
                         .per(20)

    # Filter: Category (existing)
    elsif params[:category].present?
      @products = Product.joins(:category)
                         .where(categories: { name: params[:category] })
                         .order(created_at: :desc)
                         .page(params[:page])
                         .per(20)

    # Default: Show all products
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
