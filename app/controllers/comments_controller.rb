# Controller for users
class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new comment_params
    @comment.author = current_user
    @comment.post_id = params[:post_id]
    if @comment.save
      redirect_to user_post_path(params[:user_id], params[:post_id]), notice: 'Comment added successfully!'
    else
      :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to user_post_path(params[:user_id], params[:post_id]), alert: 'Comment deleted successfully!'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
