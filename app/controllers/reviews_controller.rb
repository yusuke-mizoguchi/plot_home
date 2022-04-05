class ReviewsController < ApplicationController
before_action :set_review, only: [:show, :edit, :update, :destroy]

  def show; end

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.build(review_params)
    @novel = Novel.find_by(id: params[:novel_id])
    if @review.save
      @reviews = @novel.reviews.order(created_at: :desc).page(params[:page]).per(4)
    end
  end

  def edit
    @novel = Novel.find_by(id: params[:novel_id])
  end

  def update
    @novel = Novel.find_by(id: params[:novel_id])
    if @review.update(review_update_params)
      @reviews = @novel.reviews.order(created_at: :desc).page(params[:page]).per(4)
    end
  end

  def destroy
    @novel = Novel.find_by(id: params[:novel_id])
    if @review.destroy
      @reviews = @novel.reviews.order(created_at: :desc).page(params[:page]).per(4)
    end
  end

  private

  def set_review
    @review = current_user.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:good_point, :bad_point).merge(novel_id: params[:novel_id])
  end

  def review_update_params
    params.require(:review).permit(:good_point, :bad_point)
  end
end
