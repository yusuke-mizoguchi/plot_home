class Admin::NovelsController < Admin::BaseController
    before_action :set_novel, only: %i[show edit update destroy]

    def index
        @search = Novel.ransack(params[:q])
        @novels = @search.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
    end

    def show; end
    
    def edit; end

    def update
        if @novel.update(novel_params)
            redirect_to admin_novel_path(@novel), notice: t('defaults.message.update', item: Novel.model_name.human)
        else
            flash.now[:alert] = t('defaults.message.not_update', item: Novel.model_name.human)
            render :edit
        end
    end

    def destroy
        @novel.destroy!
        redirect_to admin_novels_path, notice: t('defaults.message.delete', item: Novel.model_name.human)
    end

    private

    def set_novel
        @novel = Novel.find(params[:id])
    end

    def novel_params
        params.require(:novel).permit(:title, :genre, :story_length, :plot, :image, :release,
            characters_attributes: [:id, :character_role, :character_text, :_destroy]).merge(
            user_id: current_user.id)
    end
end
