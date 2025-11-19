class CartsController < ApplicationController
  Line = Struct.new(:id, :quantity, :product_name, :size, :price, :line_total, keyword_init: true)

  def show
    if user_signed_in?
      @cart_items    = current_user.cart_items.includes(product_variant: :product)
      @session_lines = []
    else
      @cart_items    = []
      @session_lines = session_cart_lines
    end
  end

  private

  def session_cart_lines
    (session[:cart] || {}).map do |pv_id, qty|
      v = ProductVariant.includes(:product).find_by(id: pv_id)
      next unless v

      Line.new(
        id: pv_id,
        quantity: qty.to_i,
        product_name: v.product.name,
        size: v.size,
        price: v.price.to_f,
        line_total: v.price.to_f * qty.to_i
      )
    end.compact
  end
end
