class Admins::CategoriesController < ApplicationController
  before_action :verify_admin
  layout "admins/application"

  def index
    @categories = Category.all
  end
end
