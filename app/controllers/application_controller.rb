class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_devise_params, if: :devise_controller?


APP_DOMAIN = 'www.sitefoil.com'

def require_admin
    unless current_user && current_user.role == 'ADMIN'
      flash[:error] = "You are not an admin"
      redirect_to root_path
    end        
  end

  protected



def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:full_name, :organization, :role, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.for(:account_update) << :full_name << :status << :role << :organization
  end

 

end
