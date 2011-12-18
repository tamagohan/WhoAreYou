require 'test_helper'

class TweetsControllerTest < ActionController::TestCase
  setup do
    activate_authlogic
    @tweet = tweets(:one)
  end

  test "should get index" do
    assert(AccountSession.create(accounts(:admin)))
    get :index
    assert_response :success
    assert_not_nil assigns(:tweets)
  end

  test "should get new" do
    assert(AccountSession.create(accounts(:admin)))
    get :new
    assert_response :success
  end

  test "should create tweet" do
    assert(AccountSession.create(accounts(:admin)))
    assert_difference('Tweet.count') do
      post :create, :tweet => @tweet.attributes
    end

    assert_redirected_to tweet_path(assigns(:tweet))
  end

  test "should show tweet" do
    assert(AccountSession.create(accounts(:admin)))
    get :show, :id => @tweet.to_param
    assert_response :success
  end

  test "should get edit" do
    assert(AccountSession.create(accounts(:admin)))
    get :edit, :id => @tweet.to_param
    assert_response :success
  end

  test "should update tweet" do
    assert(AccountSession.create(accounts(:admin)))
    put :update, :id => @tweet.to_param, :tweet => @tweet.attributes
    assert_redirected_to tweet_path(assigns(:tweet))
  end

  test "should destroy tweet" do
    assert(AccountSession.create(accounts(:admin)))
    assert_difference('Tweet.count', -1) do
      delete :destroy, :id => @tweet.to_param
    end

    assert_redirected_to tweets_path
  end
end
