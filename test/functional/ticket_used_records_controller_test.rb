require 'test_helper'

class TicketUsedRecordsControllerTest < ActionController::TestCase
  setup do
    @ticket_used_record = ticket_used_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ticket_used_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ticket_used_record" do
    assert_difference('TicketUsedRecord.count') do
      post :create, :ticket_used_record => @ticket_used_record.attributes
    end

    assert_redirected_to ticket_used_record_path(assigns(:ticket_used_record))
  end

  test "should show ticket_used_record" do
    get :show, :id => @ticket_used_record.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @ticket_used_record.to_param
    assert_response :success
  end

  test "should update ticket_used_record" do
    put :update, :id => @ticket_used_record.to_param, :ticket_used_record => @ticket_used_record.attributes
    assert_redirected_to ticket_used_record_path(assigns(:ticket_used_record))
  end

  test "should destroy ticket_used_record" do
    assert_difference('TicketUsedRecord.count', -1) do
      delete :destroy, :id => @ticket_used_record.to_param
    end

    assert_redirected_to ticket_used_records_path
  end
end
