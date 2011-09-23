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
    # 容错，不保证一定严格排序处理
    section = define_in_tags_section(category, define)
    # 找到对应位置上是否已经有该tag
    if tags.length >= section + 1 && tags[section] && tags[section] != ''
      
      # 如果当前tag是0,清理掉所有的同节点values
      if value
        values = tags[section].split(',')
        
        # 如果已经有该链接,从URL里删除,否则添加
        if values.include?(value.id.to_s)
          values.delete_at(values.index(value.id.to_s))
          if values.length == 0
            values << "0"
          end
          tags[section] = values.join(',')
        else
          if tags[section] == "0"
            tags[section] = value.id.to_s
          else
            tags[section] = value.id.to_s + ',' + tags[section]
          end
        end
      else
        tags[section] = "0"
      end
    end
    "/category/#{category.id}/#{tags.join('-')}/#{params[:keywords]}"
  end
  
  def value_selected?(category, define, value)
    tags = []
    if params[:tags]
      tags = params[:tags].split('-')
      section = define_in_tags_section(category, define)
      if tags.length >= section + 1 && tags[section] && tags[section] != ''
        values = tags[section].split(',')
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
  
  def define_in_tags_section(category, define)
    category.product_attribute_defines.where(:search => true).each_with_index do |item, index|
      if item.id == define.id
        return index
      end
    end
    return 0
  end
  
end