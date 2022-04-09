class ApplicationController < ActionController::Base
    before_action :require_login

    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from ActionController::RoutingError, with: :render_404

    def render_404
        render template: 'static_pages/404_error', status: 404, layout: 'application', content_type: 'text/html'
    end

    private

    def not_authenticated
        flash[:alert] = t('defaults.message.require_login')
        redirect_to login_path
    end
end
