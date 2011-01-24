module ProductsHelper
  
  # 生成查询URL
  def search_path(id, sort)    
    tags = []
    if params[:tags]
      tags = params[:tags].split('-')
    else
      tags_count = ProductAttributeDefine.where(:search => true).count(:id)
      tags = Array.new(tags_count, "0")
    end
    # sort字段必须是按照0,1,2,3严格排序,不能有跳数字或者重复的情况

    # 找到对应位置上是否已经有该tag
    if tags.length > sort + 1 && tags[sort] && tags[sort] != ''
      values = tags[sort].split(',')
      unless values.include?(id.to_s)
        if tags[sort] == "0"
          tags[sort] = id.to_s
        else
          tags[sort] = id.to_s + ',' + tags[sort]
        end
      end
    end
    
    "/category/#{tags.join('-')}/#{params[:keywords]}"
  end
  
  # 判断当前id是否选中
  def checked?(id ,sort)
    tags = []
    if params[:tags]
      tags = params[:tags].split('-')
      if tags.length > sort + 1 && tags[sort] && tags[sort] != ''
        values = tags[sort].split(',')
        unless values.include?(id.to_s)
          return true
        end
      end
    end
    
    return false
  end

end
