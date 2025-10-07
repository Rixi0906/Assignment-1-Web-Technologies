class Order < ApplicationRecord
  belongs_to :user, foreign_key: "user_id", primary_key: "rut"
  belongs_to :address
  has_many :order_items, dependent: :destroy

  validates :status, inclusion: { in: %w[pending paid shipped delivered], message: "%{value} is not valid" }
  validates :total, numericality: { greater_than_or_equal_to: 0 }

  before_validation :set_default_status

  private

  def set_default_status
    self.status ||= "pending"
  end
end
