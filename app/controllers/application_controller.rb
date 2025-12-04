class ApplicationController < ActionController::Base
  # Enable sessions and CSRF protection
  protect_from_forgery with: :exception

  # Permit extra fields for Devise
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # Permit extra fields for sign up
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :province, :address])
    # Permit extra fields for account update (edit)
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :province, :address])
  end
end
