class NovelsController < ApplicationController
  before_action :set_novel, only: [:show, :edit, :update]
  skip_before_action :require_login, only: [:index, :show]

  def index
    @q = Novel.ransack(params[:q])
    @novels = @q.result(distinct: true).includes(:user).order(created_at: :desc)
  end

  def new
    @novel = Novel.new
    unless current_user.role == "writer"
      render novels_path
    end
  end

  def create
    @novel = Novel.new(novel_params)
    if @novel.save
      redirect_to novels_path
    else
      render :new
    end
  end

  def show
    @review = Review.new
    @reviews = @novel.reviews.includes(:user).order(created_at: :desc)

    if @novel.user.id == current_user.id
      render "novels/show"
    elsif (@novel.release != "draft") && current_user&.role == "writer"
      render "novels/show"
    elsif (@novel.release == "release" || @novel.release == "reader") && current_user&.role == "reader"
      render "novels/show"
    elsif @novel.release == "release"
      render "novels/show"
    else
      render novels_path
    end
  end

  def edit
    unless @novel.user.id == current_user.id
      redirect_to novel_path(@novel)
    end
  end

  def update
    if @novel.update(novel_params)
      redirect_to novel_path(params[:id])
    else
      render :new
    end
  end

  def destroy
    @novel.destroy!
    redirect_to novels_path
  end

  private

  def set_novel
    @novel = current_user.novels.find(params[:id])
  end

  def novel_params
    params.require(:novel).permit(
                  :title, :genre, :story_length, :plot, :image, :release,
                  character_attributes: [:id, :character_role, :character_text, :_destroy]).merge(
                  user_id: current_user.id)
  end
end
