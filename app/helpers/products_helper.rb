module ProductsHelper
  def search_path(value, sort)    
    tags = []
    if params[:tags]
      tags = params[:tags].split('-')
    else
      tags_count = ProductAttributeDefine.count(:id)
      tags = Array.new(tags_count, "0")
    end
    # sort字段必须是按照0,1,2,3严格排序,不能有跳数字或者重复的情况

    # 找到对应位置上是否已经有该tag
    values = tags[sort].split(',')
    unless values.include?(value)
      if tags[sort] == "0"
        tags[sort] = value
      else
        tags[sort] = value + ',' + tags[sort]
      end
    end
    
    "/category/#{tags.join('-')}/#{params[:keywords]}"
  end
  
  def checked?(tag,value)
    
  end
end
