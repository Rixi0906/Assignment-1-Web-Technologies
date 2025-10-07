class ProductVariantsController < ApplicationController
  def index
    @product_variants = ProductVariant.includes(:product)
  end

  def show
    @product_variant = ProductVariant.find(params[:id])
  end
end
