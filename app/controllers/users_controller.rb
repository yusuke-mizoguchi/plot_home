class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
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
    if @user.id == current_user&.id
      @narrow = @user.novels
    elsif @user.novels.where.not(release: 'draft') && current_user&.role == "writer"
      @narrow = @user.novels.where.not(release: 'draft')
    elsif user_narrow && current_user&.role == "reader"
      @narrow = user_narrow
    elsif @user.novels.where(release: 'release')
      @narrow = @user.novels.where(release: 'release')
    end
    @user_novels = @narrow.order(created_at: :desc).page(params[:novel_page]).per(4)

    @reviews = Review.select(:novel_id).where(comment: nil, id: Review.select("DISTINCT ON (novel_id) id").order(:novel_id, created_at: :desc)).order(created_at: :desc)
    @user_reviews = @reviews.page(params[:review_page]).per(4)
  end

  def edit
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

  def user_narrow
    @user.novels.where(release: 'reader').or(@user.novels.where(release: 'release'))
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :profile)
  end

  def set_user
    @user = User.find(params[:id])
  end
end