class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?

  add_flash_types :success, :danger

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :email ])
  end
end
