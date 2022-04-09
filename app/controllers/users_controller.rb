class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  skip_before_action :require_login, only: [:new, :create, :show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, notice: t('.success')
    else
      flash.now[:alert] = t('.fail')
      render :new
    end
  end

  def show
    @user = User.find(params[:id])

    @user_novels = @user.novels.order(created_at: :desc).page(params[:novel_page]).per(4)
    @user_reviews = @user.reviews.order(created_at: :desc).page(params[:review_page]).per(4)
  end

  def edit
    @user = User.find(params[:id])
    unless @user.id == current_user&.id
      flash[:alert] = t('defaults.message.not_authorized')
      redirect_to user_path(current_user)
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: t('defaults.message.update', item: User.model_name.human)
    else
      flash.now[:alert] = t('defaults.message.not_update', item: User.model_name.human)
      render :edit
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
