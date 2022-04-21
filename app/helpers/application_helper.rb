module ApplicationHelper
  def page_title(page_title = '')
    base_title = 'PlotHome - プロットホーム(管理画面)'
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def active_if(path)
    path == controller_path ? 'active' : ''
  end

  def default_meta_tags
    {
      site: 'PlotHome - プロットホーム',
      reverse: true,
      separator: '|',
      description: '小説のプロットを投稿し、批評し合う場所です。書き手、読み手を問わず、率直な批評をお待ちしております。',
      keywords: 'プロットホーム,plothome,小説,批評',
      canonical: 'https://www.plot-home.com',
      noindex: ! Rails.env.production?,
      icon: [
        { href: image_url('favicon.ico') },
        { href: image_url('apple_touch.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' },],
      og: {
        title: :site,
        description: :description, 
        type: 'website',
        url: 'https://www.plot-home.com',
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
