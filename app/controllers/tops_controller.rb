class TopsController < ApplicationController
    skip_before_action :require_login

    def top
        @reviews = Review.select(:user_id).where(comment: nil, id: Review.select("DISTINCT ON (user_id) id").order(:user_id, created_at: :desc)).order(created_at: :desc).limit(3)
        @novels_post = Novel.where.not(release: 'draft').order(created_at: :desc)

        if current_user&.role == 'writer' && @novels_post.where.not(release: 'draft')
            @narrow = @novels_post.where.not(release: 'draft')
        elsif current_user&.role == 'reader' && top_narrow
            @narrow = top_narrow
        elsif @novels_post.where(release: 'release')
            @narrow = @novels_post.where(release: 'release')
        end

        @novels = @narrow.limit(3)
    end

    private

    def top_narrow
        @novels_post.novels.where(release: 'reader').or(@user.novels.where(release: 'release'))
    end
end
