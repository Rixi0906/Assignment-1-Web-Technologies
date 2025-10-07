class Product < ApplicationRecord
  has_many :product_variants, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
