class StaticPagesController < ApplicationController
  def home; end

  def set_language
    store_location
    cookies.permanent[:language] = params[:locale]
    current_user.update(locale: params[:locale]) if user_signed_in?
    redirect_back fallback_location: root_path
  end
end
