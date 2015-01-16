class SessionsController < ApplicationController

  def new
  end

  def create
    name = params[:name]
    password = params[:password]
    user = User.find_by name: name
    if user.password == password
      session[:user_id] = user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def signout
    session[:user_id] = nil
    redirect_to root_path
  end

  def signup
    @user = User.new
  end

  def create_user
    @user = User.new(params.require(:user).permit(:name, :password,:password_confirmation, :photo_url))
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :signup
    end
  end

end
