# -*- encoding : utf-8 -*-
module ApplicationHelper
  def menu_is_highlight(name)
    # 如果@menu变量里没有内容，则显示home
    # 否则根据变量里的内容判断
    if @menu && @menu == name
      return true
    elsif @menu == nil && name == "home"
      return true
    else
      return false
    end
  end
end
