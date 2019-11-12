class DashboardController < ActionController::Base
  # include ApplicationHelper

  protect_from_forgery with: :exception
  before_action :load_categories
  before_action :set_locale

  private

  def load_categories
    @categories = Category.order(:name)
  end

  def set_locale
    locale = cookies[:language].to_s.strip.to_sym
    I18n.locale = if I18n.available_locales.include?(locale)
                    locale
                  else
                    I18n.default_locale
                  end
  end
end
