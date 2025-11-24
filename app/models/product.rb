class Product < ApplicationRecord
  has_one_attached :image

  # Association
  belongs_to :category, optional: true  # optional: true if some products may not have a category

  # Allowlist searchable attributes for Ransack (columns)
  def self.ransackable_attributes(auth_object = nil)
    ["id", "name", "description", "price", "stock_quantity", "created_at", "updated_at"]
  end

  # Allowlist searchable associations for Ransack
  def self.ransackable_associations(auth_object = nil)
    ["category"]  # now you can filter products by category in ActiveAdmin
  end
end
