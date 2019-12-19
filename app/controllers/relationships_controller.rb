class RelationshipsController < ApplicationController
  before_action :verify_user
  before_action :find_user, only: %i(create)
  before_action :find_relationship, only: %i(destroy)

  def create
    current_user.follow @user
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @user = @relationship.followed
    current_user.unfollow @user
    respond_to do |format|
      format.js
    end
  end

  private

  def find_user
    @user = User.friendly.find params[:followed_id]
    return if @user && @user.confirmed?
    flash[:danger] = t "helpers.error[user_not_found]"
    redirect_to root_url
  end

  def find_relationship
    @relationship = Relationship.find params[:id]
    return if @relationship
    flash[:danger] = t "helpers.error[relationship_not_found]"
    redirect_to root_url
  end
end
