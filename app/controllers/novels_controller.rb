class NovelsController < ApplicationController
  before_action :set_novel, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_login, only: [:index, :show]

  def index
    #公開範囲毎に表示する小説を振り分け
    if Novel.where.not(release: 'draft') && current_user&.role == "writer"
      @q = Novel.where.not(release: 'draft').ransack(params["q"])
    elsif novel_narrow && current_user&.role == "reader"
      @q = novel_narrow.ransack(params["q"])
    elsif Novel.where(release: 'release')
      @q = Novel.where(release: 'release').ransack(params["q"])
    end

    @novels = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page]).per(15)
  end

  def new
    @novel = Novel.new
    unless current_user&.role == "writer"
      render novels_path, flash.now[:alert] = t('defaults.message.not_authorized')
    end
  end

  def create
    @novel = Novel.new(novel_params)
    if @novel.save
      redirect_to novels_path, notice: t('defaults.message.created', item: Novel.model_name.human)
    else
      flash.now[:alert] = t('defaults.message.not_created', item: Novel.model_name.human)
      render new_novel_path
    end
  end

  def show
    @review = Review.new
    @reviews = @novel.reviews.includes(:user).order(created_at: :desc)

    #公開範囲毎にアクセスできる小説を振り分け
    if @novel.user.id == current_user&.id
      render "novels/show"
    elsif (@novel.release != "draft") && current_user&.role == "writer"
      render "novels/show"
    elsif (@novel.release == "release" || @novel.release == "reader") && current_user&.role == "reader"
      render "novels/show"
    elsif @novel.release == "release"
      render "novels/show"
    else
      flash[:alert] = t('defaults.message.not_authorized')
      redirect_to novels_path
    end
  end

  def edit
    @user = @novel.user_id
    unless @user == current_user&.id
      flash[:alert] = t('defaults.message.not_authorized')
      redirect_to novel_path(@novel)
    end
  end

  def update
    if @novel.update(novel_params)
      redirect_to novel_path(params[:id]), notice: t('defaults.message.update', item: Novel.model_name.human)
    else
      flash.now[:alert] = t('defaults.message.not_update', item: Novel.model_name.human)
      render :edit
    end
  end

  def destroy
    @novel.destroy!
    redirect_to novels_path, alert: t('defaults.message.delete', item: Novel.model_name.human)
  end

  private

  #メソッド化で記述省略
  def novel_narrow
    Novel.where(release: 'reader').or(Novel.where(release: 'release'))
  end

  def set_novel
    @novel = Novel.find(params[:id])
  end

  def novel_params
    params.require(:novel).permit(
                  :title, :genre, :story_length, :plot, :image, :release,
                  characters_attributes: [:id, :character_role, :character_text, :_destroy]).merge(
                  user_id: current_user.id)
  end
end
