# app/models/static_page.rb
class StaticPage < ApplicationRecord
  # other code, validations, associations, etc.

  # Ransack: allow these attributes to be searchable in ActiveAdmin
  def self.ransackable_attributes(auth_object = nil)
    %w[id title slug content created_at updated_at]
  end
end
