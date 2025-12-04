class OrdersController < ApplicationController
  before_action :authenticate_customer!

  def index
    @orders = current_customer.orders.includes(:order_items)
  end

  def show
    @order = current_customer.orders.find(params[:id])
    @order.calculate_totals   # calculate totals including GST, PST, HST
  end
end
