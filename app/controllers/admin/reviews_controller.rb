class Admin::ReviewsController < Admin::BaseController
    before_action :set_review, only: %i[show edit update destroy]

    def index
      @search = Review.ransack(params[:q])
      @reviews = @search.result(distinct: true).order(created_at: :desc).page(params[:page])
    end
    
    def show; end
  
    def edit; end
  
    def update
      if @review.update(review_params)
        redirect_to admin_review_path(@review), notice: t('defaults.message.update', item: Review.model_name.human)
      else
        flash.now[:alert] = t('defaults.message.not_update', item: Review.model_name.human)
        render :edit
      end
    end
  
    def destroy
      @review.destroy!
      redirect_to admin_reviews_path, notice: t('defaults.message.delete', item: Review.model_name.human)
    end
  
    private
  
    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
        params.require(:review).permit(:good_point, :bad_point)
    end
end
