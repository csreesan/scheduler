class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_devise_params, if: :devise_controller?
  def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:name, :email, :password, :password_confirmation, :current_password)
    end
  end

  private
  def check_admin
    if not user_signed_in? or not current_user.admin?
      flash[:alert] = "You do not have permission for this action"
      redirect_to root_path
    end
  end

  private
  def check_logged_in
    if not user_signed_in?
      flash[:alert] = "Sign in to continue"
      redirect_to new_user_session_path
    end
  end
  private
  def check_comment
    if not Setting.find_by(name: 'comments').value == "1"
        flash[:alert] = "Commenting has been disabled"
        redirect_to root_path
    end
  end
  private
  def check_enrollment(enrollment)
    if current_user and enrollment and enrollment.user_id == current_user.id
      return true
    end
    return false
  end
end
