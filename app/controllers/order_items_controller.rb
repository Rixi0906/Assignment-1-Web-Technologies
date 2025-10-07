class OrderItemsController < ApplicationController
  def index
    @order_items = OrderItem.includes(:order, :product_variant)
  end

  def show
    @order_item = OrderItem.find(params[:id])
  end
end
