class Api::PostsController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @posts = Post.all
      render json: @posts
    end
  end
  