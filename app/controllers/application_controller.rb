class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :configure_devise_params, if: :devise_controller?
  protect_from_forgery with: :exception

  def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation,
               user_detail_attributes: [:first_name, :last_name])
    end
  end
end
