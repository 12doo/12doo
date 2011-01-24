module ProductsHelper
  
  # 生成查询URL,格式0-0-0-1,2,3-4,5-0
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
      
      # 如果当前tag是0,清理掉所有的同节点values
      if id == 0
        tags[sort] = "0"
      else
        values = tags[sort].split(',')
        
        # 如果已经有该链接,从URL里删除,否则添加
        if values.include?(id.to_s)
          values.delete_at(values.index(id.to_s))
          tags[sort] = values.join(',')
        else
          if tags[sort] == "0"
            tags[sort] = id.to_s
          else
            tags[sort] = id.to_s + ',' + tags[sort]
          end
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
