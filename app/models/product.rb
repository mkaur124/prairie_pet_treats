class Product < ApplicationRecord
  has_one_attached :image

  belongs_to :category, optional: true

  def self.ransackable_attributes(auth_object = nil)
    %w[id name description price stock_quantity created_at updated_at category_id]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[category]
  end
end
