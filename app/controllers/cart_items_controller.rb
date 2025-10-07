class CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.includes(:user, :product_variant)
  end

  def show
    @cart_item = CartItem.find(params[:id])
  end
end
