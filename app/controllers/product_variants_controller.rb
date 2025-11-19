class ProductVariantsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_product
  before_action :set_variant, only: [:edit, :update, :destroy]

  def new
    @product_variant = @product.product_variants.new
  end

  def create
    @product_variant = @product.product_variants.new(variant_params)
    if @product_variant.save
      redirect_to @product, notice: "Tamaño creado correctamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @product_variant.update(variant_params)
      redirect_to @product, notice: "Tamaño actualizado correctamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product_variant.destroy
    redirect_to @product, notice: "Tamaño eliminado."
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_variant
    @product_variant = @product.product_variants.find(params[:id])
  end

  def variant_params
    params.require(:product_variant).permit(:size, :price, :stock)
  end
end
