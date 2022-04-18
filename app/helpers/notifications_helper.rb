module NotificationsHelper
    def notification_form(notification)
        @visitor = notification.visitor
        @review = nil
        @visitor_review = notification.review_id
        @review = Review.find_by(id: @visitor_review)
        @review_good = @review.good_point
        @review_bad = @review.bad_point
        @micropost_title =@review.novel.title
        tag.a(@visitor.name, href: user_path(@visitor)) + 'さんが' + 
        tag.a("#{notification.novel.title}", href: novel_path(notification.novel_id)) + 'を批評しました'
    end

    def unchecked_notifications
        @notifications = current_user.passive_notifications.where(checked: false)
    end
end
