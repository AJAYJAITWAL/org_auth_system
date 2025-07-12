class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_organization

  def current_organization
    @current_organization ||= Organization.find_by(id: session[:organization_id])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:date_of_birth, :parental_consent_given])
    devise_parameter_sanitizer.permit(:account_update, keys: [:date_of_birth, :parental_consent_given])
  end
end
