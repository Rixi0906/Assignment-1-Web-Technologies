class CartItemsController < ApplicationController
  before_action :set_item, only: [:update, :destroy]

  def index
    redirect_to cart_path
  end

  # ADD
  def create
    pv_id = cart_item_params[:product_variant_id].to_s
    qty   = cart_item_params[:quantity].to_i.clamp(1, 10_000)
    variant = ProductVariant.find(pv_id)

    if logged_in?
      item = current_user.cart_items.find_or_initialize_by(product_variant_id: variant.id)
      item.quantity = item.quantity.to_i + qty
      if within_stock?(variant, item.quantity) && item.save
        redirect_back fallback_location: product_path(variant.product, variant_id: variant.id),
                      notice: "Producto agregado al carrito."
      else
        redirect_back fallback_location: product_path(variant.product, variant_id: variant.id),
                      alert: "No hay stock suficiente."
      end
    else
      session[:cart] ||= {}
      session[:cart][pv_id] = session[:cart][pv_id].to_i + qty
      redirect_back fallback_location: product_path(variant.product, variant_id: variant.id),
                    notice: "Producto agregado al carrito (invitado)."
    end
  rescue ActiveRecord::RecordNotFound
    redirect_back fallback_location: products_path, alert: "Variante inválida."
  end

  # UPDATE QTY
  def update
    if logged_in?
      if @item.update(cart_item_params)
        redirect_to cart_path, notice: "Carrito actualizado."
      else
        redirect_to cart_path, alert: "Revisa la cantidad."
      end
    else
      pv_id = params[:id].to_s
      qty   = cart_item_params[:quantity].to_i.clamp(1, 10_000)
      session[:cart][pv_id] = qty if session[:cart]&.key?(pv_id)
      redirect_to cart_path, notice: "Carrito actualizado."
    end
  end

  # REMOVE
  def destroy
    if logged_in?
      @item.destroy
    else
      pv_id = params[:id].to_s
      session[:cart]&.delete(pv_id)
    end
    redirect_to cart_path, notice: "Ítem eliminado."
  end

  private

  def set_item
    @item = current_user.cart_items.find(params[:id]) if logged_in?
  end

  def cart_item_params
    params.require(:cart_item).permit(:product_variant_id, :quantity)
  end

  def within_stock?(variant, qty)
    variant.stock.nil? || qty <= variant.stock
  end
end
