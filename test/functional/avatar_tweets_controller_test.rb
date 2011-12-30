require 'test_helper'

class AvatarTweetsControllerTest < ActionController::TestCase
  setup do
    @av_tweet = avatar_tweets(:one)
    activate_authlogic
  end

  ### index
  test "should get index" do
    assert(AccountSession.create(accounts(:admin)))
    get :index
    assert_response :success
    assert_not_nil assigns(:avatar_tweets)
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
  test "should show avatar_tweet" do
    assert(AccountSession.create(accounts(:admin)))
    get :show, :id => @av_tweet.to_param
    assert_response :success
    assert_template :show
  end

  test "should not show my avatar_tweet by general user" do
    general_user = accounts(:one)
    assert(AccountSession.create(general_user))

    get :show, :id => @av_tweet.to_param
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not show other user's avatar_tweet by general user" do
    general_user = accounts(:general)
    assert(AccountSession.create(general_user))

    get :show, :id => @av_tweet.to_param
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not show twitter by not user" do
    get :show, :id => @av_tweet.to_param
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
    get :edit, :id => @av_tweet.to_param
    assert_response :success
  end

  test "should not get edit my avatar_tweet by general user" do
    general_user = accounts(:one)
    assert(AccountSession.create(general_user))

    get :edit, :id => @av_tweet.to_param
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not get edit by not user" do
    get :edit, :id => @av_tweet.to_param
    assert_response 302
    assert_redirected_to new_account_session_path
  end

  ### create
  test "should create avatar_tweet" do
    assert(AccountSession.create(accounts(:admin)))
    assert_difference('AvatarTweet.count') do
      post :create, :avatar_tweet => @av_tweet.attributes
    end

    assert_redirected_to avatar_tweet_path(assigns(:avatar_tweet))
  end

  test "should not create twitter by general user" do
    general_user = accounts(:general)
    assert(AccountSession.create(general_user))

    assert_no_difference('AvatarTweet.count') do
      post :create, :twitter => @av_tweet.attributes
    end
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not create twitter by not user" do
    assert_no_difference('AvatarTweet.count') do
      post :create, :twitter => @av_tweet.attributes
    end
    assert_response 302
    assert_redirected_to new_account_session_path
  end

  ### update
  test "should update avatar_tweet" do
    assert(AccountSession.create(accounts(:admin)))
    put :update, :id => @av_tweet.to_param, :avatar_tweet => @av_tweet.attributes
    assert_redirected_to avatar_tweet_path(assigns(:avatar_tweet))
  end

  test "should not update my avatar_tweet by general user" do
    general_user = accounts(:one)
    assert(AccountSession.create(general_user))

    get :update, :id => @av_tweet.to_param, :twitter => @av_tweet.attributes
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not update by not user" do
    get :edit, :id => @av_tweet.to_param
    assert_response 302
    assert_redirected_to new_account_session_path
  end

  ### destroy
  test "should destroy avatar_tweet" do
    assert(AccountSession.create(accounts(:admin)))
    assert_difference('AvatarTweet.count', -1) do
      delete :destroy, :id => @av_tweet.to_param
    end
    assert_redirected_to avatar_tweets_path
  end

  test "should not destroy my avatar_tweet by general user" do
    general_user = accounts(:one)
    assert(AccountSession.create(general_user))

    assert_no_difference('Twitter.count') do
      delete :destroy, :id => @av_tweet.to_param
    end
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not destroy by not user" do
    assert_no_difference('Twitter.count') do
      delete :destroy, :id => @av_tweet.to_param
    end
    assert_response 302
    assert_redirected_to new_account_session_path
  end
end
