module ItemsHelper
  def item_lists(items)
    html = ''
    items.each do |item|
      html += render(partial: 'item', locals: { item: item })
    end
    raw(html)
  end
end
