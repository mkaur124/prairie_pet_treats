class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product, optional: true

  # VALIDATIONS (minimal because it's a join model)
  validates :quantity, presence: true, numericality: { only_integer: true }
  validates :price, presence: true, numericality: true

  # Ransack: allowlisted attributes for ActiveAdmin filters
  def self.ransackable_attributes(auth_object = nil)
    %w[id order_id product_id quantity price created_at updated_at]
  end

  # Optional: allowlist associations
  def self.ransackable_associations(auth_object = nil)
    %w[order product]
  end
end
