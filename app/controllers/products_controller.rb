class ProductsController < ApplicationController
  # CanCanCan: authorize access to Product
  load_and_authorize_resource

  # Devise: require login for everything except browse
  before_action :authenticate_user!, except: [:index, :show]

  # ---------- PUBLIC: LIST & SHOW ----------

  # GET /products
  # Catalog view – you were listing variants directly, we keep that.
  def index
    @variants = ProductVariant.includes(:product).all
  end

  # GET /products/:id
  def show
    @product = Product.includes(:product_variants).find(params[:id])

    @selected_variant =
      if params[:variant_id].present?
        @product.product_variants.find_by(id: params[:variant_id])
      else
        @product.product_variants.first
      end
  end

  # ---------- ADMIN: CRUD PRODUCTS ----------

  # GET /products/new
  def new
    @product = Product.new
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to @product, notice: "Producto creado correctamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /products/:id/edit
  def edit
    @product = Product.find(params[:id])
  end

  # PATCH/PUT /products/:id
  def update
    @product = Product.find(params[:id])

    if @product.update(product_params)
      redirect_to @product, notice: "Producto actualizado correctamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /products/:id
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path, notice: "Producto eliminado."
  end

  private

  def product_params
    params.require(:product).permit(:name, :description)
  end
end
