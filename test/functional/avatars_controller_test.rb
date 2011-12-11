require 'test_helper'

class AvatarsControllerTest < ActionController::TestCase
  setup do
    @avatar = avatars(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:avatars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create avatar" do
    assert_difference('Avatar.count') do
      post :create, :avatar => @avatar.attributes
    end

    assert_redirected_to avatar_path(assigns(:avatar))
  end

  test "should show avatar" do
    get :show, :id => @avatar.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @avatar.to_param
    assert_response :success
  end

  test "should update avatar" do
    put :update, :id => @avatar.to_param, :avatar => @avatar.attributes
    assert_redirected_to avatar_path(assigns(:avatar))
  end

  test "should destroy avatar" do
    assert_difference('Avatar.count', -1) do
      delete :destroy, :id => @avatar.to_param
    end

    assert_redirected_to avatars_path
  end
end
