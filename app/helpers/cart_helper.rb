# -*- encoding : utf-8 -*-
module CartHelper
  def find_cart
    session[:cart] ||= Cart.new
  end
end
