class CartItem < ApplicationRecord
  belongs_to :user, foreign_key: "user_id", primary_key: "rut"
  belongs_to :product_variant

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

  validate :stock_available

  private

  def stock_available
    if product_variant.present? && quantity > product_variant.stock
      errors.add(:quantity, "Exceeds available stock")
    end
  end
end
