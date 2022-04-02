class TopsController < ApplicationController
    skip_before_action :require_login

    def top
        @reviews = Review.order(created_at: :desc).limit(1)
    end
end
