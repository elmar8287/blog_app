#  Controller for posts
class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.find(params[:user_id])
    @users = User.all
    @user_posts = Post.includes(:author).where(author: @user)
    @comments = Comment.all
  end

  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @comments = @post.comments.all.order(created_at: :desc)
    @users = User.all
    @likes = @post.likes.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    @post.author = current_user
    if @post.save

      redirect_to user_posts_path, notice: 'Post added successfully!'
    else
      flash[:alert] = @post.errors.first.full_message
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to user_posts_path, alert: 'Post deleted successfully!'
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
