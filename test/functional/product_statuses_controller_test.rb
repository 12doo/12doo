require 'test_helper'

class ProductStatusesControllerTest < ActionController::TestCase
  setup do
    @product_status = product_statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_statuses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_status" do
    assert_difference('ProductStatus.count') do
      post :create, :product_status => @product_status.attributes
    end

    assert_redirected_to product_status_path(assigns(:product_status))
  end

  test "should show product_status" do
    get :show, :id => @product_status.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @product_status.to_param
    assert_response :success
  end

  test "should update product_status" do
    put :update, :id => @product_status.to_param, :product_status => @product_status.attributes
    assert_redirected_to product_status_path(assigns(:product_status))
  end

  test "should destroy product_status" do
    assert_difference('ProductStatus.count', -1) do
      delete :destroy, :id => @product_status.to_param
    end

    assert_redirected_to product_statuses_path
  end
end
