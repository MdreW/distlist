class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from ActiveRecord::RecordNotFound, :with => :access_denied!
  before_filter :set_locale
 
  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale 
  end

  def default_url_options(options={})
    {:locale => I18n.locale}
  end

  def record_not_found
    redirect_to(root_path, :notice => "Pagina non trovata", :status => 404)
  end

  def access_denied!
    redirect_to(root_path, :notice => "accesso non consentito", :status => 401)
  end

  def admin_required!
    access_denied! unless current_user.try(:admin?)
  end
end
