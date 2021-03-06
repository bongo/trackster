panel t('.pageview_graph')  do
  block do
    page_views = @page_views || @property.page_views_by_date(params).all
    if page_views.empty? || (page_views.size == 1 && page_views.first.page_views == "0")
      h3 t('no_page_views_yet')
    else
      store page_views.to_chart(:page_views, :date, :tooltip => "Date: #x_label#\nViews: #val#", :regression => true)
    end
  end
end