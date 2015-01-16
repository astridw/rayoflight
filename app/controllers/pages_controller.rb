class PagesController < ApplicationController

  before_action do
    if session[:user_id].present?
    else
      redirect_to sign_in_path
    end
  end

  def index
    @users = User.all
    @posts = current_user.posts.order("created_at desc")
    @post = Post.new
    @allposts = Post.all
    @followings = Following.all
    if params[:unfollow_user_id]
      @followings = Following.where(user_id: params[:unfollow_user_id], follower_id: current_user.id )
      @followings.first.destroy
      redirect_to root_path, :flash => { :info => "The user was successfully unfollowed" }
    end

  end
end
