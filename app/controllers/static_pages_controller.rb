class StaticPagesController < ApplicationController
    skip_before_action :require_login

    def rule; end

    def privacy; end

    def about; end
end
