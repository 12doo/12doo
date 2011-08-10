require 'test_helper'

class WikiPagesControllerTest < ActionController::TestCase
  setup do
    @wiki_page = wiki_pages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wiki_pages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wiki_page" do
    assert_difference('WikiPage.count') do
      post :create, :wiki_page => @wiki_page.attributes
    end

    assert_redirected_to wiki_page_path(assigns(:wiki_page))
  end

  test "should show wiki_page" do
    get :show, :id => @wiki_page.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @wiki_page.to_param
    assert_response :success
  end

  test "should update wiki_page" do
    put :update, :id => @wiki_page.to_param, :wiki_page => @wiki_page.attributes
    assert_redirected_to wiki_page_path(assigns(:wiki_page))
  end

  test "should destroy wiki_page" do
    assert_difference('WikiPage.count', -1) do
      delete :destroy, :id => @wiki_page.to_param
    end

    assert_redirected_to wiki_pages_path
  end
end
