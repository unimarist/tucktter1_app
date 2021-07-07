class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    added_attrs = [:email,:LastName,:FirstName,:birthday,:aWord,:favoriteSubject,:Nickname,:student_or_coach,:university,:department,:major,:admin, :user_icon, :password, :password_confirmation, :remember_me, :user_identification]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
