class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy

  # Calculate totals based on items and province
  def calculate_totals
    self.subtotal = order_items.sum { |item| item.price * item.quantity }
    self.tax = TaxCalculator.calculate(subtotal, customer.province)
    self.total = subtotal + tax
  end
end
