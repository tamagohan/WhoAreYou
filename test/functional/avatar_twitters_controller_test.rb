require 'test_helper'

class AvatarTwittersControllerTest < ActionController::TestCase
  setup do
    @avatar_twitter = avatar_twitters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:avatar_twitters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create avatar_twitter" do
    assert_difference('AvatarTwitter.count') do
      post :create, :avatar_twitter => @avatar_twitter.attributes
    end

    assert_redirected_to avatar_twitter_path(assigns(:avatar_twitter))
  end

  test "should show avatar_twitter" do
    get :show, :id => @avatar_twitter.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @avatar_twitter.to_param
    assert_response :success
  end

  test "should update avatar_twitter" do
    put :update, :id => @avatar_twitter.to_param, :avatar_twitter => @avatar_twitter.attributes
    assert_redirected_to avatar_twitter_path(assigns(:avatar_twitter))
  end

  test "should destroy avatar_twitter" do
    assert_difference('AvatarTwitter.count', -1) do
      delete :destroy, :id => @avatar_twitter.to_param
    end

    assert_redirected_to avatar_twitters_path
  end
end
