require 'test_helper'

class ProductAttributesControllerTest < ActionController::TestCase
  setup do
    @product_attribute = product_attributes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_attributes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_attribute" do
    assert_difference('ProductAttribute.count') do
      post :create, :product_attribute => @product_attribute.attributes
    end

    assert_redirected_to product_attribute_path(assigns(:product_attribute))
  end

  test "should show product_attribute" do
    get :show, :id => @product_attribute.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @product_attribute.to_param
    assert_response :success
  end

  test "should update product_attribute" do
    put :update, :id => @product_attribute.to_param, :product_attribute => @product_attribute.attributes
    assert_redirected_to product_attribute_path(assigns(:product_attribute))
  end

  test "should destroy product_attribute" do
    assert_difference('ProductAttribute.count', -1) do
      delete :destroy, :id => @product_attribute.to_param
    end

    assert_redirected_to product_attributes_path
  end
end
