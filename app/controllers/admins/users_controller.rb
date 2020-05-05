class Admins::UsersController < ApplicationController
  before_action :verify_admin
  layout "admins/application"

  def index
    @users = User.order_desc
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:info] = t "alert.success[add_user]"
      redirect_to admins_users_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "alert.success[update_user]"
      redirect_to admins_users_path
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "alert.success[delete_user]"
    else
      flash[:danger] = t "alert.error[delete_user]"
    end
    redirect_to admins_users_path
  end

  def lock
    @user.lock_access!
    flash[:success] = t "alert.success[lock_user]"
    edirect_to admins_users_path
  end

  private

  def user_params
    params.require(:user).permit :email, :name, :parent_id
  end

  def find_user
    @user = User.find_by(id: params[:id])
    return if @user
    flash.now[:danger] = t "flash.not_found_user"
    redirect_to admins_users_path
  end
end
