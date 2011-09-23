# -*- encoding : utf-8 -*-
module SearchHelper
  
  def cat_path(category)
    tags_count = ProductAttributeDefine.where("category_id = (:cat_id) and search = :search", :cat_id => category.id, :search => true).count(:id)
    "/category/#{category.id}/#{Array.new(tags_count, "0").join('-')}/"
  end
  
  def cat_path_with_selected_value(category, define, value)
    tags = []
    if params[:tags]
      tags = params[:tags].split('-')
    else
      tags_count = ProductAttributeDefine.where("category_id = (:cat_id) and search = :search", :cat_id => category.id, :search => true).count(:id)
      tags = Array.new(tags_count, "0")
    end
    # sort字段必须是按照0,1,2,3严格排序,不能有跳数字或者重复的情况

    # 找到对应位置上是否已经有该tag
    if tags.length >= define.sort + 1 && tags[define.sort] && tags[define.sort] != ''
      
      # 如果当前tag是0,清理掉所有的同节点values
      if value
        values = tags[define.sort].split(',')
        
        # 如果已经有该链接,从URL里删除,否则添加
        if values.include?(value.id.to_s)
          values.delete_at(values.index(value.id.to_s))
          if values.length == 0
            values << "0"
          end
          tags[define.sort] = values.join(',')
        else
          if tags[define.sort] == "0"
            tags[define.sort] = value.id.to_s
          else
            tags[define.sort] = value.id.to_s + ',' + tags[define.sort]
          end
        end
      else
        tags[define.sort] = "0"
      end
    end
    "/category/#{category.id}/#{tags.join('-')}/#{params[:keywords]}"
  end
  
  def value_selected?(define, value)
    tags = []
    if params[:tags]
      tags = params[:tags].split('-')
      if tags.length >= define.sort + 1 && tags[define.sort] && tags[define.sort] != ''
        values = tags[define.sort].split(',')
        if value
          unless values.include?(value.id.to_s)
            return true
          end
        else
          unless values.include?("0")
            return true
          end
        end
      end
    end
    
    return false
  end
  
  def sort_by?(sort)
    if params[:sort_by] && params[:sort_by] == sort && params[:sort] && params[:sort] == "0"
      return true
    end
    
    return false
  end
  
  def cat_path_with_sort(sort_by, sort)
    "/category/#{params[:cat]}/#{params[:tags]}/#{params[:keywords]}?sort_by=#{sort_by}&sort=#{sort}"
  end
  
end