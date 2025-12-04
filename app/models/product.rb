class Product < ApplicationRecord
  has_one_attached :image

  belongs_to :category, optional: true
  #RELATIONSHIPS
  has_many :order_items
  has_many :orders, through: :order_items

  # VALIDATIONS
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: true
  validates :stock_quantity, presence: true, numericality: { only_integer: true }

  # Ransack configuration (searchable attributes)
  def self.ransackable_attributes(auth_object = nil)
    %w[id name description price stock_quantity created_at updated_at category_id]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[category]
  end
end
