class ReviewsController < ApplicationController
before_action :set_review, only: [:show, :edit, :update, :destroy]

  def show; end

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.build(review_params)
    @review.save
  end

  def edit
    @novel = @review.novel.id
  end

  def update
    @novel = @review.novel.id
    if @review.update(review_update_params)
      redirect_to novel_path(@novel)
    end
  end

  def destroy
    @review.destroy!
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
