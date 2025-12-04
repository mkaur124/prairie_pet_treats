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

  # --- Added create action with custom flash + session ---
  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      # Store last created product in session
      session[:last_created_product] = @product.name

      # Custom flash message
      flash[:custom_message] = "Product '#{@product.name}' created! Last product: #{session[:last_created_product]}"

      redirect_to @product
    else
      flash[:custom_message] = "Failed to create product."
      render :new
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id)
  end
end
