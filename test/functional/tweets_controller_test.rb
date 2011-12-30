require 'test_helper'

class TweetsControllerTest < ActionController::TestCase
  setup do
    activate_authlogic
    @tweet = tweets(:one)
  end


  ### index
  test "should get index" do
    assert(AccountSession.create(accounts(:admin)))
    get :index
    assert_response :success
    assert_not_nil assigns(:tweets)
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
  test "should show tweet" do
    assert(AccountSession.create(accounts(:admin)))
    get :show, :id => @tweet.to_param
    assert_response :success
    assert_template :show
  end

  test "should not show tweet by general user" do
    general_user = accounts(:one)
    assert(AccountSession.create(general_user))

    get :show, :id => @tweet.to_param
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not show tweet by not user" do
    get :show, :id => @tweet.to_param
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
    get :edit, :id => @tweet.to_param
    assert_response :success
  end

  test "should not get edit by general user" do
    general_user = accounts(:one)
    assert(AccountSession.create(general_user))

    get :edit, :id => @tweet.to_param
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not get edit by not user" do
    get :edit, :id => @tweet.to_param
    assert_response 302
    assert_redirected_to new_account_session_path
  end

  ### create
  test "should create tweet" do
    assert(AccountSession.create(accounts(:admin)))
    assert_difference('Tweet.count') do
      post :create, :tweet => @tweet.attributes
    end
    assert_redirected_to tweet_path(assigns(:tweet))
  end

  test "should not create tweet by general user" do
    general_user = accounts(:general)
    assert(AccountSession.create(general_user))

    assert_no_difference('Tweet.count') do
      post :create, :twitter => @tweet.attributes
    end
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not create tweet by not user" do
    assert_no_difference('Tweet.count') do
      post :create, :twitter => @tweet.attributes
    end
    assert_response 302
    assert_redirected_to new_account_session_path
  end

  ### update
  test "should update tweet" do
    assert(AccountSession.create(accounts(:admin)))
    put :update, :id => @tweet.to_param, :tweet => @tweet.attributes
    assert_redirected_to tweet_path(assigns(:tweet))
  end

  test "should not update by general user" do
    general_user = accounts(:one)
    assert(AccountSession.create(general_user))

    get :update, :id => @tweet.to_param, :twitter => @tweet.attributes
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not update by not user" do
    get :edit, :id => @tweet.to_param
    assert_response 302
    assert_redirected_to new_account_session_path
  end

  ### destroy
  test "should destroy tweet" do
    assert(AccountSession.create(accounts(:admin)))
    assert_difference('Tweet.count', -1) do
      delete :destroy, :id => @tweet.to_param
    end

    assert_redirected_to tweets_path
  end

  test "should not destroy twitter by general user" do
    general_user = accounts(:one)
    assert(AccountSession.create(general_user))

    assert_no_difference('Tweet.count') do
      delete :destroy, :id => @tweet.to_param
    end
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not destroy by not user" do
    assert_no_difference('Tweet.count') do
      delete :destroy, :id => @tweet.to_param
    end
    assert_response 302
    assert_redirected_to new_account_session_path
  end
end
