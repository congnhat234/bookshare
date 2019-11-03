class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :load_categories

  private

  def load_categories
    @categories = Category.order(:name)
  end
end
