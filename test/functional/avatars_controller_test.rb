require 'test_helper'

class AvatarsControllerTest < ActionController::TestCase
  setup do
    activate_authlogic
    @avatar = avatars(:one)
  end

  test "should get index" do
    assert(AccountSession.create(accounts(:admin)))
    get :index
    assert_response :success
    assert_not_nil assigns(:avatars)
  end

  test "should get new" do
    assert(AccountSession.create(accounts(:general)))
    get :new
    assert_response :success
  end

  test "should create avatar" do
    assert(AccountSession.create(accounts(:general)))
    assert_difference('Avatar.count') do
      post :create, :avatar => @avatar.attributes
    end

    assert_redirected_to avatar_path(assigns(:avatar))
  end

  test "should show avatar" do
    assert(AccountSession.create(accounts(:admin)))
    get :show, :id => @avatar.id
    assert_response :success
  end

  test "should get edit" do
    assert(AccountSession.create(accounts(:admin)))
    get :edit, :id => @avatar.to_param
    assert_response :success
  end

  test "should update avatar" do
    assert(AccountSession.create(accounts(:admin)))
    put :update, :id => @avatar.to_param, :avatar => @avatar.attributes
    assert_redirected_to avatar_path(assigns(:avatar))
  end

  test "should destroy avatar" do
    assert(AccountSession.create(accounts(:admin)))
    assert_difference('Avatar.count', -1) do
      delete :destroy, :id => @avatar.to_param
    end

    assert_redirected_to avatars_path
  end
end
