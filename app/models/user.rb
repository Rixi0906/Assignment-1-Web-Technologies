class User < ApplicationRecord
  self.primary_key = "rut"
  has_secure_password

  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders,     dependent: :destroy

  attr_accessor :first_name, :last_name, :accept_terms

  before_validation :compose_name

  validates :rut,  presence: true, uniqueness: true, numericality: { only_integer: true }
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, inclusion: { in: %w[customer admin], message: "%{value} is not a valid role" }

  validates :accept_terms, acceptance: { message: "Debes aceptar los términos"}

  private
  def compose_name
    self.name = [first_name, last_name].compact_blank.join(" ") if name.blank?
  end
end
