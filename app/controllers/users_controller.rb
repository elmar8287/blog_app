# Controller for users
class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all.order('id')
  end

  def show
    @user = User.find(params[:id])
    @user_posts = @user.recent_posts
    @comments = Comment.all
  end
end
