atom_feed do |feed|
  feed.title("十二度红酒网--您身边的葡萄酒")
  feed.updated(@products.first.created_at)
  @products.each do |product|
    feed.entry(product) do |entry|
      entry.title(product.cn_name)
      entry.summary(product.name)
      entry.content(product.memo, :type => 'html')
      entry.author do |author|
        author.name('十二度红酒网')
      end
    end
  end
end