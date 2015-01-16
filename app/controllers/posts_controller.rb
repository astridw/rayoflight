class PostsController < ApplicationController

  before_action do
    if session[:user_id].present?
    else
      redirect_to sign_in_path
    end
  end

  def new
    @post = Post.new
  end

  def post
    @post = Post.new(params.require(:post).permit(:post))
    @post.user = current_user
    if @post.save
      redirect_to root_path
    else
      render :index
    end
  end
end
