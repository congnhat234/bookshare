class StaticPagesController < ApplicationController
  def home; end

  def set_language
    store_location
    cookies[:language] = params[:locale]
    redirect_back fallback_location: root_path
  end
end
