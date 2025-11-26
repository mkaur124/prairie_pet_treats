class Category < ApplicationRecord
  has_many :products

  # Allowlist attributes for Ransack search
  def self.ransackable_attributes(auth_object = nil)
    %w[id name created_at updated_at]
  end

  # Allowlist associations for Ransack search
  def self.ransackable_associations(auth_object = nil)
    %w[products]
  end
end
