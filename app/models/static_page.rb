# app/models/static_page.rb
class StaticPage < ApplicationRecord
  # VALIDATIONS
  validates :title, presence: true
  validates :slug, presence: true
  validates :content, presence: true

  # Ransack: allow these attributes to be searchable in ActiveAdmin
  def self.ransackable_attributes(auth_object = nil)
    %w[id title slug content created_at updated_at]
  end
end
