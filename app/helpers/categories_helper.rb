# -*- encoding : utf-8 -*-
module CategoriesHelper
  def cat_path(*cats)
    tags_count = ProductAttributeDefine.where("category_id in (:ids) and search = :search", :ids => cats, :search => true).count(:id)
    "/category/#{cats.join('-')}/#{Array.new(tags_count, "0").join('-')}/"
  end
end
