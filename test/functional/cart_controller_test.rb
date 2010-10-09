require 'test_helper'

class CartControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get clear" do
    get :clear
    assert_response :success
  end

  test "should get deleteitem" do
    get :deleteitem
    assert_response :success
  end

  test "should get updateitem" do
    get :updateitem
    assert_response :success
  end

  test "should get additem" do
    get :additem
    assert_response :success
  end

end
