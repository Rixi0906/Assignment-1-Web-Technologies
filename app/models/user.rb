class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Use RUT as the primary key (already set in schema)
  self.primary_key = "rut"

  # Associations
  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders,     dependent: :destroy

  # Virtual attributes used in the registration form
  attr_accessor :first_name, :last_name, :accept_terms

  # Callbacks
  before_validation :compose_name

  # Validations
  validates :rut,
            presence: true,
            uniqueness: true,
            numericality: { only_integer: true }

  validates :name, presence: true

  # Devise::Validatable already enforces presence/uniqueness/format on email,
  # but we keep this to match your previous behaviour explicitly.
  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :role,
            inclusion: { in: %w[customer admin],
                         message: "%{value} is not a valid role" }

  validates :accept_terms,
            acceptance: { message: "Debes aceptar los términos" }

  # ROLE HELPERS
  def admin?
    role == "admin"
  end

  def customer?
    role == "customer"
  end

  private

  def compose_name
    # If name is blank, build it from first_name + last_name (ignoring blanks)
    self.name = [first_name, last_name].compact_blank.join(" ") if name.blank?
  end
end
