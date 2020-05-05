class Admins::CategoriesController < ApplicationController
  before_action :verify_admin
  before_action :find_category, only: %i(show edit update destroy)
  layout "admins/application"

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:info] = t "alert.success[add_category]"
      redirect_to admins_categories_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "alert.success[update_category]"
      redirect_to admins_categories_path
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "alert.success[delete_category]"
    else
      flash[:danger] = t "alert.error[delete_category]"
    end
    redirect_to admins_categories_path
  end

  private

  def category_params
    params.require(:category).permit :name, :parent_id
  end

  def find_category
    @category = Category.find_by(id: params[:id])
    return if @category
    flash.now[:danger] = t "flash.not_found_category"
    redirect_to admins_categories_path
  end
end
