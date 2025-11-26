class ProductsController < ApplicationController
  def index
    @products = Product.all

    # Keyword search
    if params[:keyword].present?
      keyword = "%#{params[:keyword]}%"
      @products = @products.where("name LIKE ? OR description LIKE ?", keyword, keyword)
    end

    # Optional category filter for search
    if params[:search_category_id].present?
      @products = @products.where(category_id: params[:search_category_id])
    end

    # Quick Filters: New / Recently Updated
    if params[:filter] == "new"
      @products = @products.where("created_at >= ?", 3.days.ago)
    elsif params[:filter] == "updated"
      @products = @products.where("updated_at >= ?", 3.days.ago)
                           .where("created_at < ?", 3.days.ago)
    end

    # Existing category filter (dropdown at bottom)
    if params[:category_id].present?
      @products = @products.where(category_id: params[:category_id])
    end

    # Sorting + Kaminari pagination
    @products = @products.order(created_at: :desc)
                         .page(params[:page])
                         .per(20)
  end
  def show
    @product = Product.find(params[:id])
  end
end
