class TopsController < ApplicationController
    skip_before_action :require_login

    def top
        @reviews = Review.includes(:user).order(created_at: :desc).limit(3)
        @novels = Novel.includes(:user).order(created_at: :desc).limit(5)
    end
end
