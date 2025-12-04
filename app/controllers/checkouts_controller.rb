class CheckoutsController < ApplicationController
  before_action :initialize_cart, only: [:new, :create]

  def new
    @customer = customer_signed_in? ? current_customer : Customer.new
  end

  def create
    if customer_signed_in?
      @customer = current_customer
      @customer.assign_attributes(customer_params.except(:password, :password_confirmation))
    else
      @customer = Customer.find_or_initialize_by(email: customer_params[:email])
      @customer.assign_attributes(customer_params)
    end

    if @customer.save
      @order = @customer.orders.build
      session[:cart].each do |product_id, qty|
        product = Product.find(product_id)
        @order.order_items.build(
          product: product,
          product_name: product.name,
          quantity: qty,
          price: product.price      # store product price at time of order

        )
      end

      # Store subtotal and taxes with the order
      @order.subtotal = @order.order_items.sum { |item| item.price * item.quantity }
      taxes = TaxCalculator.calculate(@order.subtotal, @customer.province)
      @order.gst = taxes[:gst]
      @order.pst = taxes[:pst]
      @order.hst = taxes[:hst]
      @order.tax = taxes[:total_tax]
      @order.total = @order.subtotal + @order.tax
      @order.paid = false
      @order.save!

      session[:cart] = {}
      redirect_to checkout_invoice_path(order_id: @order.id)
    else
      flash.now[:alert] = "Please fill in required details."
      render :new
    end
  end

  def invoice
    @order = Order.find(params[:order_id])
  end

  # Fake/test payment for demo purposes
  def fake_payment
    @order = Order.find(params[:order_id])
    @order.update(paid: true, payment_id: "TEST123") # mark as paid in demo
    redirect_to checkout_invoice_path(order_id: @order.id), notice: "Payment successful (test mode)"
  end

  private

  def initialize_cart
    session[:cart] ||= {}
    cart = session[:cart] || {}
    if cart.empty? && controller_name == "checkouts" && action_name != "invoice"
      redirect_to cart_path, alert: "Your cart is empty."
    end
  end

  def customer_params
    params.require(:customer).permit(:name, :email, :address, :province_id, :password, :password_confirmation)
  end
end
