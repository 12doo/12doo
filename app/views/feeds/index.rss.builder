xml.rss(:version=>"2.0"){
  xml.channel{
    xml.title("十二度红酒网--您身边的葡萄酒")
    xml.link("http://www.12doo.com/")
    xml.description("十二度红酒网--您身边的葡萄酒")
    xml.language('zh-cn')
      for post in @products
        xml.item do
          xml.title(post.cn_name)
          xml.description(post.memo)      
          xml.author("十二度红酒网")               
          xml.pubDate(post.created_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
          xml.link(product_url(post))
          xml.guid(product_url(post))
        end
      end
  }
}