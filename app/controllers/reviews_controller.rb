class ReviewsController < ApplicationController
  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      redirect_to novel_path(@review.novel)
    else
      redirect_to novel_path(@review.novel)
    end
  end

  def edit; end

  def update
    @review = current_user.reviews.find(params[:id])
    @review.update(review_params)
    redirect_to @review
  end

  def destroy
    @review = current_user.reviews.find(params[:id])
    @review.destroy!
  end

  private

  def review_params
    params.require(:review).permit(:good_point, :bad_point).merge(novel_id: params[:novel_id])
  end
end
