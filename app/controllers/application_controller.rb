class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :load_categories

  def default_url_options _options = nil
    {format: "html"}
  end

  private

  def load_categories
    @categories = Category.order(:name)
  end
end
