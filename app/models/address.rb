class Address < ApplicationRecord
  belongs_to :user, foreign_key: "user_id", primary_key: "rut"

  validates :name, presence: true
  validates :address_line, presence: true
  validates :city, presence: true
  validates :region, presence: true
  validates :postal_code, presence: true
end
