# Controller for users
class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @like = Like.new(like_params)
    @like.author = current_user
    if @like.save
      redirect_to user_post_path(@like.post.author_id, @like.post_id), notice: 'You liked this post.'
    else
      :new
    end
  end

  private

  def like_params
    params.require(:like).permit(:post_id)
  end
end
