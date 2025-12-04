class CartsController < ApplicationController
  before_action :initialize_cart

  def show
    @cart_items = session[:cart].map do |product_id, quantity|
      product = Product.find_by(id: product_id)
      next unless product
      { product: product, quantity: quantity }
    end.compact
  end

  def add
    product_id = params[:product_id].to_s
    quantity = params[:quantity].to_i
    quantity = 1 if quantity <= 0

    session[:cart][product_id] ||= 0
    session[:cart][product_id] += quantity

    redirect_to cart_path, notice: "Item added to cart."
  end

  def update
    params[:quantities]&.each do |product_id, qty|
      qty = qty.to_i
      if qty > 0
        session[:cart][product_id.to_s] = qty
      else
        session[:cart].delete(product_id.to_s)
      end
    end

    redirect_to cart_path, notice: "Cart updated."
  end

  def remove
    product_id = params[:product_id].to_s
    session[:cart].delete(product_id)

    redirect_to cart_path, notice: "Item removed from cart."
  end

  private

 def initialize_cart
  session[:cart] ||= {}
  # Convert any integer keys to strings
  session[:cart] = session[:cart].transform_keys(&:to_s)
end

end
