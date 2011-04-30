# -*- encoding : utf-8 -*-
require 'test_helper'

class ProductAttributeDefinesControllerTest < ActionController::TestCase
  setup do
    @product_attribute_define = product_attribute_defines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_attribute_defines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_attribute_define" do
    assert_difference('ProductAttributeDefine.count') do
      post :create, :product_attribute_define => @product_attribute_define.attributes
    end

    assert_redirected_to product_attribute_define_path(assigns(:product_attribute_define))
  end

  test "should show product_attribute_define" do
    get :show, :id => @product_attribute_define.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @product_attribute_define.to_param
    assert_response :success
  end

  test "should update product_attribute_define" do
    put :update, :id => @product_attribute_define.to_param, :product_attribute_define => @product_attribute_define.attributes
    assert_redirected_to product_attribute_define_path(assigns(:product_attribute_define))
  end

  test "should destroy product_attribute_define" do
    assert_difference('ProductAttributeDefine.count', -1) do
      delete :destroy, :id => @product_attribute_define.to_param
    end

    assert_redirected_to product_attribute_defines_path
  end
end
