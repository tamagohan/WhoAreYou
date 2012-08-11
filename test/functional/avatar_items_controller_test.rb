require 'test_helper'

class AvatarItemsControllerTest < ActionController::TestCase
  setup do
    @avatar_item = avatar_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:avatar_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create avatar_item" do
    assert_difference('AvatarItem.count') do
      post :create, avatar_item: @avatar_item.attributes
    end

    assert_redirected_to avatar_item_path(assigns(:avatar_item))
  end

  test "should show avatar_item" do
    get :show, id: @avatar_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @avatar_item
    assert_response :success
  end

  test "should update avatar_item" do
    put :update, id: @avatar_item, avatar_item: @avatar_item.attributes
    assert_redirected_to avatar_item_path(assigns(:avatar_item))
  end

  test "should destroy avatar_item" do
    assert_difference('AvatarItem.count', -1) do
      delete :destroy, id: @avatar_item
    end

    assert_redirected_to avatar_items_path
  end
end
