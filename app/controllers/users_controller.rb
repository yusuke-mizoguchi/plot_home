class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])

    @user_novels = @user.novels.page(params[:page]).per(1)
    @user_reviews = @user.reviews.page(params[:page]).per(1)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to root_path
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :profile)
  end

  def set_user
    @user = User.find(current_user.id)
  end
end
