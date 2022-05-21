class TopsController < ApplicationController
  skip_before_action :require_login

  def top
    #最近批評した人を抽出
    @reviews = Review.select(:user_id).where(comment: 'Review', id: Review.select("DISTINCT ON (user_id) id").order(:user_id, id: :desc)).order(id: :desc).limit(3)

    #最近投稿された作品を振り分け
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

  #メソッド化で記述省略
  def top_narrow
    @novels_post.where(release: 'reader').or(@novels_post.where(release: 'release'))
  end
end
