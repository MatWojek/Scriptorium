class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :set_locale
  before_action :check_banned
  allow_browser versions: :modern
  helper_method :current_user, :logged_in?

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes
  
  private

  def set_locale
    I18n.locale = params[:locale].presence || current_user&.language&.code || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    unless logged_in?
      redirect_to new_session_path, alert: t("base.prompt.log_in")
    end
  end

  def require_admin 
    unless current_user&.admin? 
      redirect_to root_path, alert: t("base.prompt.authorized_error")
    end
  end 

  def check_banned
    if BannedIp.exists?(ip_address: request.remote_ip)
      render plain: t("base.prompt.not_access"), status: :forbidden
    end
  end
  
end
