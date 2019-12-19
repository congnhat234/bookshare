class Admins::HomeController < ApplicationController
  before_action :verify_admin
  layout "admins/application"

  def index; end
end
