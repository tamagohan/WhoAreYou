require 'test_helper'

class AvatarTweetsControllerTest < ActionController::TestCase
  setup do
    @avatar_tweet = avatar_tweets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:avatar_tweets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create avatar_tweet" do
    assert_difference('AvatarTweet.count') do
      post :create, :avatar_tweet => @avatar_tweet.attributes
    end

    assert_redirected_to avatar_tweet_path(assigns(:avatar_tweet))
  end

  test "should show avatar_tweet" do
    get :show, :id => @avatar_tweet.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @avatar_tweet.to_param
    assert_response :success
  end

  test "should update avatar_tweet" do
    put :update, :id => @avatar_tweet.to_param, :avatar_tweet => @avatar_tweet.attributes
    assert_redirected_to avatar_tweet_path(assigns(:avatar_tweet))
  end

  test "should destroy avatar_tweet" do
    assert_difference('AvatarTweet.count', -1) do
      delete :destroy, :id => @avatar_tweet.to_param
    end

    assert_redirected_to avatar_tweets_path
  end
end
