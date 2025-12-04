class Customer < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #RELATIONSHIP
  has_many :orders
  belongs_to :province, optional: true  # <-- updated to association

  # VALIDATIONS
  validates :name, presence: true
  validates :email, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :postal_code, presence: true
  validates :province_id, presence: true

  # Ransack filters
  def self.ransackable_attributes(auth_object = nil)
    %w[id name email created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[orders province]
  end
end
