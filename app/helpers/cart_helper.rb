module CartHelper
  def find_cart
    session[:cart] ||= Cart.new
  end
end
