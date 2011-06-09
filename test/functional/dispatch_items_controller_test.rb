require 'test_helper'

class DispatchItemsControllerTest < ActionController::TestCase
  setup do
    @dispatch_item = dispatch_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dispatch_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dispatch_item" do
    assert_difference('DispatchItem.count') do
      post :create, :dispatch_item => @dispatch_item.attributes
    end

    assert_redirected_to dispatch_item_path(assigns(:dispatch_item))
  end

  test "should show dispatch_item" do
    get :show, :id => @dispatch_item.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @dispatch_item.to_param
    assert_response :success
  end

  test "should update dispatch_item" do
    put :update, :id => @dispatch_item.to_param, :dispatch_item => @dispatch_item.attributes
    assert_redirected_to dispatch_item_path(assigns(:dispatch_item))
  end

  test "should destroy dispatch_item" do
    assert_difference('DispatchItem.count', -1) do
      delete :destroy, :id => @dispatch_item.to_param
    end

    assert_redirected_to dispatch_items_path
  end
end
