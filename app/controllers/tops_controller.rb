class TopsController < ApplicationController
    skip_before_action :require_login

    def top
        @reviews = Review.order(created_at: :desc).limit(3)
        @novels = Novel.order(created_at: :desc).limit(5)
    end
end
