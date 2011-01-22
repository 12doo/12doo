module ProductsHelper
  def search_path(current_tag)
    if params[:tags]
      if params[:tags].split(',').include?(current_tag)
        return "/category/#{params[:tags]}/#{params[:keywords]}"
      else
        return "/category/#{current_tag},#{params[:tags]}/#{params[:keywords]}"
      end
    else
      return "/category/#{current_tag}/#{params[:keywords]}"
    end
  end
  
  def checked?(tag,value)
    
  end
end
