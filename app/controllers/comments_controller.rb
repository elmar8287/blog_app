class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.post_id = params[:post_id]
  end

  private

  def comment_params
    params.permit(:text)
  end
end
