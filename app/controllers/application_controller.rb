class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  # First, make sure to require Pundit
  require 'pundit'
  
  # Then include it
  include Pundit::Authorization
  
  # Ensure all controller actions are authorized (except in specific cases like Devise)
  # Uncomment this once you have policies in place for all controllers
  # after_action :verify_authorized, except: :index, unless: :skip_pundit?
  # after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?
  
  # Handle unauthorized access
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
  protected

  # Redirect to dashboard after sign in
  def after_sign_in_path_for(resource)
    dashboard_path
  end
  
  private
  
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
  
  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end