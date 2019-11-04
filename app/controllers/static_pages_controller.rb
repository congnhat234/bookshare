class StaticPagesController < ApplicationController
  def home; end

  def set_language
    store_location
    cookies.permanent[:language] = params[:locale]
    redirect_back fallback_location: root_path
  end
end
