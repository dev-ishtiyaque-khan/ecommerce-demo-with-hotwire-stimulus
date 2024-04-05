class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  add_flash_types :success, :warning, :info

  include Pagy::Backend

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def current_user_cart
    return unless user_signed_in?

    Cart.includes(cart_items: [product: :category]).find_or_create_by(user_id: current_user.id)
  end
  helper_method :current_user_cart
end
