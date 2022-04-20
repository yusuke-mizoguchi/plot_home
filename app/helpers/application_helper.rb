module ApplicationHelper
  def page_title(page_title = '', admin = false)
      base_title = if admin
                     'Plot Home(管理画面)'
                   else
                     'Plot Home'
                   end
  
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def active_if(path)
    path == controller_path ? 'active' : ''
  end

  def default_meta_tags
    {
      site: 'プロットホーム',
      reverse: true,
      separator: '|',
      description: '小説のプロットを投稿し、批評し合う場所です',
      keywords: 'プロットホーム,plothome,小説,批評',
      canonical: 'https://plot-home.com',
      noindex: ! Rails.env.production?,
      icon: [
        { href: image_url('favicon.ico') },
        { href: image_url('apple_touch.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' },],
      og: {
        title: :site,
        description: :description, 
        type: 'website',
        url: 'https://plot-home.com',
        image: image_url('ogp.jpg'),
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        site: '@Isuke626Shirobe',
      }
    }
  end
end
