class User < ApplicationRecord
  self.primary_key = "rut"

  has_secure_password

  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates :rut, presence: true, uniqueness: true, numericality: { only_integer: true }
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, inclusion: { in: %w[customer admin], message: "%{value} is not a valid role" }
end