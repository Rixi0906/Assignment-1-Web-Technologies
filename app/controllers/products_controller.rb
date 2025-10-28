class ProductsController < ApplicationController
  def index
    @variants = ProductVariant.includes(:product).all
  end

  def show
    @product = Product.find(params[:id])

    if params[:variant_id].present?
      @selected_variant = @product.product_variants.find_by(id: params[:variant_id])
    else
      @selected_variant = @product.product_variants.first
    end
  end
end
