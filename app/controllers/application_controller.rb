class ApplicationController < ActionController::Base
  # Extra fields for Devise forms
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Devise already exposes current_user / user_signed_in? as helpers
  helper_method :cart_count

  # ---------- Cart helpers ----------

  def cart_count
    if user_signed_in?
      current_user.cart_items.sum(:quantity)
    else
      (session[:cart] || {}).values.map(&:to_i).sum
    end
  end

  # Merge guest cart (session) into DB cart when user logs in / registers
  def merge_session_cart_into(user)
    return unless session[:cart].present?

    session[:cart].each do |pv_id, qty|
      item = user.cart_items.find_or_initialize_by(product_variant_id: pv_id)
      item.quantity = item.quantity.to_i + qty.to_i
      item.save
    end

    session.delete(:cart)
  end

  # ---------- Devise & CanCanCan config ----------

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,        keys: [:rut, :first_name, :last_name, :accept_terms])
    devise_parameter_sanitizer.permit(:account_update, keys: [:rut, :first_name, :last_name])
  end

  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to root_path, alert: "No tienes permiso para acceder a esta página."
  end
end
