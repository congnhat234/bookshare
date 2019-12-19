class CommentsController < ApplicationController
  before_action :verify_user
  before_action :find_comment, only: :destroy

  def create
    @comment = current_user.comments.new post_id: params[:post_id],
      parent_id: params[:parent_id], content: params[:content]
    Comment.transaction do
      @comment.save!
      render json: {
        comment: renderhtml_comment
      }
    end
  rescue ActiveRecord::RecordInvalid
    redirect_to post_path id: params[:post_id]
  end

  def destroy
    @comment.destroy
    render json: {
      status: "success"
    }
  end

  private

  def renderhtml_comment
    if params[:parent_id].present?
      ApplicationController.render partial: "posts/comment_reply",
        locals: {child_comment: @comment, current_user: current_user}
    else
      ApplicationController.render partial: "posts/comment",
        locals: {comment: @comment, current_user: current_user}
    end
  end

  def find_comment
    @comment = Comment.find_by id: params[:comment_id]
    return if @comment
    flash[:danger] = t "helpers.error[comment_not_found]"
    redirect_back fallback_location: post_path(id: params[:post_id])
  end
end
