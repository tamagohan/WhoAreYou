require 'test_helper'

class AvatarTwittersControllerTest < ActionController::TestCase
  setup do
    @av_twitter = avatar_twitters(:one)
    activate_authlogic
  end

  ### index
  test "should get index" do
    assert(AccountSession.create(accounts(:admin)))
    get :index
    assert_response :success
    assert_not_nil assigns(:avatar_twitters)
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
  test "should show avatar_twitter" do
    assert(AccountSession.create(accounts(:admin)))
    get :show, :id => @av_twitter.to_param
    assert_response :success
    assert_template :show
  end

  test "should show my avatar_twitter by general user" do
    general_user = accounts(:one)
    assert(AccountSession.create(general_user))

    get :show, :id => @av_twitter.to_param
    assert_response :success
    assert_template :show
  end

  test "should not show other user's avatar_twitter by general user" do
    general_user = accounts(:general)
    assert(AccountSession.create(general_user))

    get :show, :id => @av_twitter.to_param
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not show twitter by not user" do
    get :show, :id => @av_twitter.to_param
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
    get :edit, :id => @av_twitter.to_param
    assert_response :success
  end

  test "should not get edit my avatar_twitter by general user" do
    general_user = accounts(:one)
    assert(AccountSession.create(general_user))

    get :edit, :id => @av_twitter.to_param
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not get edit by not user" do
    get :edit, :id => @av_twitter.to_param
    assert_response 302
    assert_redirected_to new_account_session_path
  end

  ### create
  test "should create avatar_twitter" do
    assert(AccountSession.create(accounts(:admin)))
    assert_difference('AvatarTwitter.count') do
      post :create, :avatar_twitter => @av_twitter.attributes
    end

    assert_redirected_to avatar_twitter_path(assigns(:avatar_twitter))
  end

  test "should not create twitter by general user" do
    general_user = accounts(:general)
    assert(AccountSession.create(general_user))

    assert_no_difference('AvatarTwitter.count') do
      post :create, :twitter => @av_twitter.attributes
    end
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not create twitter by not user" do
    assert_no_difference('AvatarTwitter.count') do
      post :create, :twitter => @av_twitter.attributes
    end
    assert_response 302
    assert_redirected_to new_account_session_path
  end

  ### update
  test "should update avatar_twitter" do
    assert(AccountSession.create(accounts(:admin)))
    put :update, :id => @av_twitter.to_param, :avatar_twitter => @av_twitter.attributes
    assert_redirected_to avatar_twitter_path(assigns(:avatar_twitter))
  end

  test "should not update my avatar_twitter by general user" do
    general_user = accounts(:one)
    assert(AccountSession.create(general_user))

    get :update, :id => @av_twitter.to_param, :twitter => @av_twitter.attributes
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not update by not user" do
    get :edit, :id => @av_twitter.to_param
    assert_response 302
    assert_redirected_to new_account_session_path
  end

  ### destroy
  test "should destroy avatar_twitter" do
    assert(AccountSession.create(accounts(:admin)))
    assert_difference('AvatarTwitter.count', -1) do
      delete :destroy, :id => @av_twitter.to_param
    end

    assert_redirected_to avatar_twitters_path
  end

  test "should not destroy my avatar_twitter by general user" do
    general_user = accounts(:one)
    assert(AccountSession.create(general_user))

    assert_no_difference('AvatarTwitter.count') do
      delete :destroy, :id => @av_twitter.to_param
    end
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not destroy by not user" do
    assert_no_difference('AvatarTwitter.count') do
      delete :destroy, :id => @av_twitter.to_param
    end
    assert_response 302
    assert_redirected_to new_account_session_path
  end
end
