class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected
 
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:avatar, :name, :email, :password, :date_of_birth, :sex])
    devise_parameter_sanitizer.permit(:account_update, keys: [:avatar, :name, :email, :sex, :password, :current_password, 
                                            :date_of_birth, :activity, :growth, :weigth])
  end 
end
