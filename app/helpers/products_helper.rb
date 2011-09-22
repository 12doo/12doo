# -*- encoding : utf-8 -*-
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
    if tags.length >= sort + 1 && tags[sort] && tags[sort] != ''
      
      # 如果当前tag是0,清理掉所有的同节点values
      if id == 0
        tags[sort] = "0"
      else
        values = tags[sort].split(',')
        
        # 如果已经有该链接,从URL里删除,否则添加
        if values.include?(id.to_s)
          values.delete_at(values.index(id.to_s))
          if values.length == 0
            values << "0"
          end
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
  
  def search_path_init(id, sort)
    tags_count = ProductAttributeDefine.where(:search => true).count(:id)
    tags = Array.new(tags_count, "0")
    if tags_count >= sort
      tags[sort] = id
    end
    "/category/#{tags.join('-')}/"
  end
  
  def search_path_without_keywords
    if params[:tags]
      return "/category/#{params[:tags]}/"
    else
      tags_count = ProductAttributeDefine.where(:search => true).count(:id)
      return "/category/#{Array.new(tags_count, "0").join('-')}/"
    end
  end
  
  def init_search_path
    tags_count = ProductAttributeDefine.where(:search => true).count(:id)
    return "/category/#{Array.new(tags_count, "0").join('-')}/"
  end
  
  def search_path_without_sort
    "/category/#{params[:tags]}/#{params[:keywords]}"
  end
  
  def search_path_with_sort(sort_by, sort)
    "/category/#{params[:tags]}/#{params[:keywords]}?sort_by=#{sort_by}&sort=#{sort}"
  end
  
  def sort_is_already(sort_by)
    flag = false
    
    if params[:sort_by] && params[:sort_by] == sort_by && params[:sort] && params[:sort] == "0"
      flag = true
    end
    
    flag
  end
  
  def search_path_by_short_value(short, value)
    tags_count = ProductAttributeDefine.where(:search => true).count(:id)
    tags = Array.new(tags_count, "0")
    
    item = ProductAttributeDefine.find_by_short(short)
    value = ProductAttributeValue.where(:short => short, :value => value).first
    if item && value
      tags[item.sort] = value.id
    end
    "/category/#{tags.join('-')}"
  end
  
  def selected(sort_by, sort)
    if sort_by == params[:sort_by] && sort.to_s == params[:sort]
      return true
    else
      return false
    end
  end
  
  # 判断当前id是否选中
  def checked?(id ,sort)
    tags = []
    if params[:tags]
      tags = params[:tags].split('-')
      if tags.length >= sort + 1 && tags[sort] && tags[sort] != ''
        values = tags[sort].split(',')
        unless values.include?(id.to_s)
          return true
        end
      end
    end
    
    return false
  end

end
