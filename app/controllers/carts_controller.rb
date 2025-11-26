class CartsController < ApplicationController
  before_action :initialize_cart

  # GET /cart
  def show
    # Nothing else needed, session[:cart] is available in the view
  end

  # POST /cart/add
  def add
    product_id = params[:product_id].to_s
    quantity   = params[:quantity].to_i

    if quantity > 0
      session[:cart][product_id] ||= 0
      session[:cart][product_id] += quantity
      flash[:notice] = "Added #{quantity} item(s) to your cart."
    else
      flash[:alert] = "Quantity must be greater than 0."
    end

    redirect_to cart_path
  end

  # POST /cart/update
  def update
    params[:quantities]&.each do |product_id, qty|
      qty = qty.to_i
      if qty <= 0
        session[:cart].delete(product_id)
      else
        session[:cart][product_id] = qty
      end
    end
    flash[:notice] = "Cart updated successfully."
    redirect_to cart_path
  end

  # DELETE /cart/remove/:product_id
  def remove
    product_id = params[:product_id].to_s
    if session[:cart].key?(product_id)
      session[:cart].delete(product_id)
      flash[:notice] = "Item removed from cart."
    else
      flash[:alert] = "Item not found in cart."
    end
    redirect_to cart_path
  end

  private

  def initialize_cart
    session[:cart] ||= {}
  end
end
