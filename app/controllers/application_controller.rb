class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :cart_count

  def current_user
    @current_user ||= User.find_by(rut: session[:user_rut]) if session[:user_rut]
  end

  def logged_in? = current_user.present?

  def cart_count
    if logged_in?
      current_user.cart_items.sum(:quantity)
    else
      (session[:cart] || {}).values.map(&:to_i).sum
    end
  end

  def merge_session_cart_into(user)
    return unless session[:cart].present?

    session[:cart].each do |pv_id, qty|
      item = user.cart_items.find_or_initialize_by(product_variant_id: pv_id)
      item.quantity = item.quantity.to_i + qty.to_i
      item.save
    end

    session.delete(:cart)
  end
end
