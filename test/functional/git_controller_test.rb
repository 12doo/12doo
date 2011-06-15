require 'test_helper'

class GitControllerTest < ActionController::TestCase
  test "should get add" do
    get :add
    assert_response :success
  end

  test "should get ." do
    get :.
    assert_response :success
  end

end
