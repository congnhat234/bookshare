class Admins::UsersController < ApplicationController
  before_action :verify_admin
  layout "admins/application"

  def index
    @users = User.order_desc
  end
end
