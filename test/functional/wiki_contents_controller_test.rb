require 'test_helper'

class WikiContentsControllerTest < ActionController::TestCase
  setup do
    @wiki_content = wiki_contents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wiki_contents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wiki_content" do
    assert_difference('WikiContent.count') do
      post :create, :wiki_content => @wiki_content.attributes
    end

    assert_redirected_to wiki_content_path(assigns(:wiki_content))
  end

  test "should show wiki_content" do
    get :show, :id => @wiki_content.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @wiki_content.to_param
    assert_response :success
  end

  test "should update wiki_content" do
    put :update, :id => @wiki_content.to_param, :wiki_content => @wiki_content.attributes
    assert_redirected_to wiki_content_path(assigns(:wiki_content))
  end

  test "should destroy wiki_content" do
    assert_difference('WikiContent.count', -1) do
      delete :destroy, :id => @wiki_content.to_param
    end

    assert_redirected_to wiki_contents_path
  end
end
