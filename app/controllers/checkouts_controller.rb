class CheckoutsController < ApplicationController
  before_action :initialize_cart

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.find_or_initialize_by(email: params[:customer][:email])
    @customer.assign_attributes(customer_params)
    if @customer.save
      @order = @customer.orders.build

      session[:cart].each do |product_id, qty|
        product = Product.find(product_id)
        @order.order_items.build(
          product: product,
          quantity: qty,
          price: product.price
        )
      end

      @order.subtotal = @order.order_items.sum { |item| item.price * item.quantity }
      @order.tax = TaxCalculator.calculate(@order.subtotal, @customer.province)
      @order.total = @order.subtotal + @order.tax
      @order.save!

      session[:cart] = {} # clear cart
      redirect_to checkout_invoice_path(order_id: @order.id)
    else
      flash.now[:alert] = "Please fill in required details."
      render :new
    end
  end

  def invoice
    @order = Order.find(params[:order_id])
  end

  private

  def initialize_cart
    session[:cart] ||= {}
    redirect_to cart_path, alert: "Your cart is empty." if session[:cart].empty?
  end

  def customer_params
    params.require(:customer).permit(:name, :email, :address, :province)
  end
end
