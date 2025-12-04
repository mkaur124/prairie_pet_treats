class Page < ApplicationRecord

  # VALIDATIONS
  validates :title, presence: true
  validates :slug, presence: true
  validates :content, presence: true

  # Add this method to allow searching on specific columns
  def self.ransackable_attributes(auth_object = nil)
    %w[id title slug content created_at updated_at]
  end

  # Add this if your Page model is allowed to be queried
  def self.ransackable_associations(auth_object = nil)
    []  # or add associations if Page has belongs_to/has_many
  end

end
