require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  setup do
    @item = items(:one)
    activate_authlogic
  end


  ### index
  test "should get index" do
    assert(AccountSession.create(accounts(:admin)))
    get :index
    assert_response :success
    assert_not_nil assigns(:items)
  end

  test "should not get index by general user" do
    general_user = accounts(:general)
    assert(AccountSession.create(general_user))

    get :index
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not get index by not user" do
    get :index
    assert_response 302
    assert_redirected_to new_account_session_path
  end

  ### show
  test "should show item" do
    assert(AccountSession.create(accounts(:admin)))
    get :show, :id => @item.to_param
    assert_response :success
    assert_template :show
  end

  test "should show my item by general user" do
    general_user = accounts(:one)
    assert(AccountSession.create(general_user))

    get :show, :id => @item.to_param
    assert_response :success
    assert_template :show
  end

  test "should not show other user's item by general user" do
    general_user = accounts(:general)
    assert(AccountSession.create(general_user))

    get :show, :id => @item.to_param
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not show twitter by not user" do
    get :show, :id => @item.to_param
    assert_response 302
    assert_redirected_to new_account_session_path
  end

  ### new
  test "should get new" do
    assert(AccountSession.create(accounts(:admin)))
    get :new
    assert_response :success
  end

  test "should not get new by general user" do
    general_user = accounts(:general)
    assert(AccountSession.create(general_user))

    get :new
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not get new by not user" do
    get :new
    assert_response 302
    assert_redirected_to new_account_session_path
  end

  ### edit
  test "should get edit" do
    assert(AccountSession.create(accounts(:admin)))
    get :edit, :id => @item.to_param
    assert_response :success
  end

  test "should not get edit item by general user" do
    general_user = accounts(:one)
    assert(AccountSession.create(general_user))

    get :edit, :id => @item.to_param
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not get edit by not user" do
    get :edit, :id => @item.to_param
    assert_response 302
    assert_redirected_to new_account_session_path
  end

  ### create
  test "should create item" do
    assert(AccountSession.create(accounts(:admin)))
    assert_difference('Item.count') do
      post :create, :item => @item.attributes
    end

    assert_redirected_to item_path(assigns(:item))
  end

  test "should not create item by general user" do
    general_user = accounts(:general)
    assert(AccountSession.create(general_user))

    assert_no_difference('Item.count') do
      post :create, :twitter => @item.attributes
    end
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not create item by not user" do
    assert_no_difference('Item.count') do
      post :create, :twitter => @item.attributes
    end
    assert_response 302
    assert_redirected_to new_account_session_path
  end

  ### update
  test "should update item" do
    assert(AccountSession.create(accounts(:admin)))
    put :update, :id => @item.to_param, :item => @item.attributes
    assert_redirected_to item_path(assigns(:item))
  end

  test "should not update by general user" do
    general_user = accounts(:one)
    assert(AccountSession.create(general_user))

    get :update, :id => @item.to_param, :twitter => @item.attributes
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not update by not user" do
    get :edit, :id => @item.to_param
    assert_response 302
    assert_redirected_to new_account_session_path
  end

  ### destroy
  test "should destroy item" do
    assert(AccountSession.create(accounts(:admin)))
    assert_difference('Item.count', -1) do
      delete :destroy, :id => @item.to_param
    end

    assert_redirected_to items_path
  end

  test "should not destroy item by general user" do
    general_user = accounts(:one)
    assert(AccountSession.create(general_user))

    assert_no_difference('Item.count') do
      delete :destroy, :id => @item.to_param
    end
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not destroy item by not user" do
    assert_no_difference('Item.count') do
      delete :destroy, :id => @item.to_param
    end
    assert_response 302
    assert_redirected_to new_account_session_path
  end

end
