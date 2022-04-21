class TopsController < ApplicationController
    skip_before_action :require_login

    def top
        @reviews = Review.includes(:user).order(created_at: :desc).limit(3)
        @novels = Novel.where.not(release: 'draft').includes(:user).order(created_at: :desc).limit(3)
    end
end
