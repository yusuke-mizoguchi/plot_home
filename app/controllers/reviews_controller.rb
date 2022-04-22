class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_novel, only: [:new, :create, :edit, :update, :destroy]

  def show; end

  def new
    @review = @novel.reviews.new(parent_id: params[:parent_id])
  end

  def create
    @review = current_user&.reviews.build(review_params)
    @review.novel_id = @novel.id
    @review.user_id = current_user.id
    if @review.save
      @novel.create_notification_review(current_user, @review.id)
      @reviews = @novel.reviews.order(created_at: :desc)
    end
  end

  def edit; end

  def update
    if @review.update(review_update_params)
      @reviews = @novel.reviews.order(created_at: :desc)
    end
  end

  def destroy
    @reply = @review
    if @review.destroy || @reply.destroy
      @reviews = @novel.reviews.order(created_at: :desc)
    end
  end

  private

  def set_review
    @review = current_user.reviews.find(params[:id])
  end

  def set_novel
    @novel = Novel.find_by(id: params[:novel_id])
  end

  def review_params
    params.require(:review).permit(:good_point, :bad_point, :comment, :parent_id).merge(novel_id: params[:novel_id])
  end

  def review_update_params
    params.require(:review).permit(:good_point, :bad_point)
  end
end
