class ApplicationController < ActionController::API
  #protect_from_forgery with: :null_session
  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :configure_permitted_parameters, if: :devise_controller?
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    #devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :phoneno, :whoyou, :whatteach, :whatlearn, :address, :country, :state, :pincode, :city, :password, :password_confirmation, :current_password, :profic ) }
  end

end