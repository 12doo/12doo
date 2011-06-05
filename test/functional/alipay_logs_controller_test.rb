require 'test_helper'

class AlipayLogsControllerTest < ActionController::TestCase
  setup do
    @alipay_log = alipay_logs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:alipay_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create alipay_log" do
    assert_difference('AlipayLog.count') do
      post :create, :alipay_log => @alipay_log.attributes
    end

    assert_redirected_to alipay_log_path(assigns(:alipay_log))
  end

  test "should show alipay_log" do
    get :show, :id => @alipay_log.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @alipay_log.to_param
    assert_response :success
  end

  test "should update alipay_log" do
    put :update, :id => @alipay_log.to_param, :alipay_log => @alipay_log.attributes
    assert_redirected_to alipay_log_path(assigns(:alipay_log))
  end

  test "should destroy alipay_log" do
    assert_difference('AlipayLog.count', -1) do
      delete :destroy, :id => @alipay_log.to_param
    end

    assert_redirected_to alipay_logs_path
  end
end
