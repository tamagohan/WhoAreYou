require 'test_helper'

class TwittersControllerTest < ActionController::TestCase
  setup do
    @twitter = twitters(:one)
    activate_authlogic
  end

  ################## AuthLogic test #######################
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

  test "should show my twitter by general user" do
    general_user = accounts(:one)
    assert(AccountSession.create(general_user))

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

  #########################################################

  ### oauth
  test "should redirect to twitter" do
    post :oauth
    assert /http:\/\/api.twitter.com\/oauth\/authorize/ =~ @response.body
  end

  ### callback
  test "should create new twitter." do
    general_user = accounts(:not_has_twitter)
    assert(AccountSession.create(general_user))
    consumer = OAuth::Consumer.new(
      AppConfig[:twitter_consumer_key],
      AppConfig[:twitter_consumer_secret],
      { :site => "http://api.twitter.com" }
    )
    request_token = OAuth::RequestToken.new(
      consumer,
      AppConfig[:twitter_test_bot_oauth_token],
      AppConfig[:twitter_test_bot_oauth_verifier]
    )

    assert_difference('Twitter.count') do
      assert_difference('AvatarTwitter.count') do
        OAuth::RequestToken.any_instance.stubs(:get_access_token).returns(request_token)
        get :callback
        OAuth::RequestToken.any_instance.unstub(:get_access_token)
      end
    end
    assert_template :controller => :avatars, :action => :show, :id => general_user.avatar.id
  end

  test "should not create new twitter." +
    "because user not allow to access twitter." do
    general_user = accounts(:not_has_twitter)
    assert(AccountSession.create(general_user))

    assert_no_difference('Twitter.count') do
      assert_no_difference('AvatarTwitter.count') do
        get :callback
      end
    end
    assert_template :controller => :avatars, :action => :show, :id => general_user.avatar.id
  end

  ### get_tweets
  test "should redirect to oauth" do
    post :get_tweets
    assert_redirected_to :action => :oauth
  end

  test "should not redirect to oauth, and save tweet" do
    general_user = accounts(:anatta_test_bot)
    assert(AccountSession.create(general_user))
    session[:oauth] = true
    session[:oauth_token] = general_user.twitter.oauth_token
    session[:oauth_verifier] = general_user.twitter.oauth_verifier
    tweets_count = get_test_bot_tweets_count(general_user.twitter)

    assert_difference('Tweet.count', tweets_count) do
      assert_difference('AvatarTweet.count', tweets_count) do
        assert_no_difference('Twitter.count') do
          assert_no_difference('AvatarTwitter.count') do
            post :get_tweets
          end
        end
      end
    end
    assert_template :controller => :avatar, :action => :show
  end

  ### show
  test "should analyze favorite phrase" do
    general_user = accounts(:anatta_test_bot)
    twitter = general_user.twitter
    assert(AccountSession.create(general_user))

    session[:oauth] = true
    session[:oauth_token] = twitter.oauth_token
    session[:oauth_verifier] = twitter.oauth_verifier

    get :show, :id => twitter.id.to_s
    assert_response :success
    assert_template :show
    assert_equal 'test'.to_sym, assigns(:favorite_phrase)[0][0]
    assert_equal get_test_bot_tweets_count(twitter), assigns(:favorite_phrase)[0][1]
  end


  def get_test_bot_tweets_count(twitter)
    consumer = OAuth::Consumer.new(
      AppConfig[:twitter_consumer_key],
      AppConfig[:twitter_consumer_secret],
      { :site => "http://api.twitter.com" }
    )
    token = OAuth::AccessToken.new(
        consumer,
        twitter.oauth_token,
        twitter.oauth_verifier
      )
    rubytter = OAuthRubytter.new(token)
    id = rubytter.verify_credentials.id_str
    @friends_timelines = rubytter.user_timeline(id)
    return @friends_timelines.count
  end
end
