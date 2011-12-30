require 'test_helper'

class TwittersControllerTest < ActionController::TestCase
  setup do
    @twitter = twitters(:one)
    activate_authlogic
  end

  ### index
  test "should get index" do
    assert(AccountSession.create(accounts(:admin)))
    get :index
    assert_response :success
    assert_not_nil assigns(:twitters)
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
  test "should show twitter" do
    assert(AccountSession.create(accounts(:admin)))
    get :show, :id => @twitter.to_param
    assert_response :success
    assert_template :show
  end

  test "should not show other user's twitter by general user" do
    general_user = accounts(:general)
    assert(AccountSession.create(general_user))

    get :show, :id => @twitter.to_param
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not show twitter by not user" do
    get :show, :id => @twitter.to_param
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
    get :edit, :id => @twitter.to_param
    assert_response :success
  end

  test "should not get edit twitter by general user" do
    general_user = accounts(:one)
    assert(AccountSession.create(general_user))

    get :edit, :id => @twitter.to_param
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not get edit by not user" do
    get :edit, :id => @twitter.to_param
    assert_response 302
    assert_redirected_to new_account_session_path
  end

  ### create
  test "should create twitter" do
    assert(AccountSession.create(accounts(:admin)))
    assert_difference('Twitter.count') do
      post :create, :twitter => @twitter.attributes
    end
    assert_redirected_to twitter_path(assigns(:twitter))
  end

  test "should not create twitter by general user" do
    general_user = accounts(:general)
    assert(AccountSession.create(general_user))

    assert_no_difference('Twitter.count') do
      post :create, :twitter => @twitter.attributes
    end
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not create twitter by not user" do
    assert_no_difference('Twitter.count') do
      post :create, :twitter => @twitter.attributes
    end
    assert_response 302
    assert_redirected_to new_account_session_path
  end

  ### update
  test "should update twitter" do
    assert(AccountSession.create(accounts(:admin)))
    put :update, :id => @twitter.to_param, :twitter => @twitter.attributes
    assert_redirected_to twitter_path(assigns(:twitter))
  end

  test "should not update by general user" do
    general_user = accounts(:one)
    assert(AccountSession.create(general_user))

    get :update, :id => @twitter.to_param, :twitter => @twitter.attributes
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not update by not user" do
    get :edit, :id => @twitter.to_param
    assert_response 302
    assert_redirected_to new_account_session_path
  end

  ### destroy
  test "should destroy twitter" do
    assert(AccountSession.create(accounts(:admin)))
    assert_difference('Twitter.count', -1) do
      delete :destroy, :id => @twitter.to_param
    end

    assert_redirected_to twitters_path
  end

  test "should not destroy twitter by general user" do
    general_user = accounts(:one)
    assert(AccountSession.create(general_user))

    assert_no_difference('Twitter.count') do
      delete :destroy, :id => @twitter.to_param
    end
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not destroy by not user" do
    assert_no_difference('Twitter.count') do
      delete :destroy, :id => @twitter.to_param
    end
    assert_response 302
    assert_redirected_to new_account_session_path
  end

end
