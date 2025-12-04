class Order < ApplicationRecord
  belongs_to :customer
  #RELATIONSHIPS
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  # Stripe/payment enum using status_int column
  enum status_int: { pending: 0, paid: 1, shipped: 2, cancelled: 3 }, _prefix: true

  before_create :set_default_status

  # VALIDATIONS
  validates :subtotal, numericality: true, allow_nil: true
  validates :gst, numericality: true, allow_nil: true
  validates :pst, numericality: true, allow_nil: true
  validates :hst, numericality: true, allow_nil: true
  validates :total, numericality: true, allow_nil: true

  def set_default_status
    self.status_int ||= "pending"
  end

  def snapshot!
    update(
      order_snapshot: {
        items: order_items.map do |i|
          {
            product: i.product.name,
            quantity: i.quantity,
            price: i.product.price
          }
        end,
        totals: {
          subtotal: subtotal,
          gst: gst,
          pst: pst,
          hst: hst,
          tax: tax,
          total: total
        }
      }
    )
  end

  def calculate_totals
    self.subtotal = order_items.sum { |item| item.price * item.quantity }

    province_name = customer.province&.name || "Ontario"

    tax_hash = TaxCalculator.calculate(subtotal, province_name)
    self.gst = tax_hash[:gst]
    self.pst = tax_hash[:pst]
    self.hst = tax_hash[:hst]
    self.tax = tax_hash[:total_tax]
    self.total = subtotal + self.tax
  end

  # ActiveAdmin / ransack
  def self.ransackable_associations(_auth_object = nil)
    %w[customer order_items products]
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[id gst pst hst total created_at status_int]
  end
end
