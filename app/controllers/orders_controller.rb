class OrdersController < ApplicationController
  def index
    @orders = Order.includes(:user, :address, :order_items)
  end

  def show
    @order = Order.includes(:order_items, :address, :user).find(params[:id])
  end
end
