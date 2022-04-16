class Admin::UsersController < Admin::BaseController
    before_action :set_user, only: %i[show edit update destroy]

    def index
        @search = User.ransack(params[:q])
        @users = @search.result(distinct: true).order(created_at: :desc).page(params[:page])
    end
    
    def show; end

    def edit; end

    def update
        if @user.update(user_params)
            redirect_to admin_user_path(@user), notice: t('defaults.message.update', item: User.model_name.human)
        else
            flash.now[:alert] = t('defaults.message.not_update', item: User.model_name.human)
            render :edit
        end
    end

    def destroy
        @user.destroy!
        redirect_to admin_users_path, notice: t('defaults.message.delete', item: User.model_name.human)
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :profile)
    end
end
