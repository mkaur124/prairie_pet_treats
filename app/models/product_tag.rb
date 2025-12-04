class ProductTag < ApplicationRecord
  belongs_to :product
  belongs_to :tag

  # Allow Ransack to search these attributes
  def self.ransackable_attributes(auth_object = nil)
    %w[id product_id tag_id created_at updated_at]
  end
end
