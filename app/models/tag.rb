class Tag < ApplicationRecord
  has_many :product_tags
  has_many :products, through: :product_tags

  validates :name, presence: true

  def self.ransackable_associations(auth_object = nil)
    %w[product_tags products]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[id name created_at updated_at]
  end
end
