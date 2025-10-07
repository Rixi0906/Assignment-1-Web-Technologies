class ProductsController < ApplicationController
  def index
    @variants = ProductVariant.includes(:product).all
  end

  def show
    @product = Product.find(params[:id])
  end
end
