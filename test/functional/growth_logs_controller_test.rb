require 'test_helper'

class GrowthLogsControllerTest < ActionController::TestCase
  setup do
    @growth_log = growth_logs(:one)
    activate_authlogic
  end


  ### index
  test "should get index" do
    assert(AccountSession.create(accounts(:admin)))
    get :index
    assert_response :success
    assert_not_nil assigns(:growth_logs)
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
  test "should show growth_log" do
    assert(AccountSession.create(accounts(:admin)))
    get :show, :id => @growth_log.to_param
    assert_response :success
  end

  test "should not show growth log by general user" do
    general_user = accounts(:one)
    assert(AccountSession.create(general_user))

    get :show, :id => @growth_log.to_param
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not show growth log by not user" do
    get :show, :id => @growth_log.to_param
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
    get :edit, :id => @growth_log.to_param
    assert_response :success
  end

  test "should not get edit my growth_log by general user" do
    general_user = accounts(:one)
    assert(AccountSession.create(general_user))

    get :edit, :id => @growth_log.to_param
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not get edit by not user" do
    get :edit, :id => @growth_log.to_param
    assert_response 302
    assert_redirected_to new_account_session_path
  end

  ### create
  test "should create growth_log" do
    assert(AccountSession.create(accounts(:admin)))
    assert_difference('GrowthLog.count') do
      post :create, :growth_log => @growth_log.attributes
    end

    assert_redirected_to growth_log_path(assigns(:growth_log))
  end

  test "should not create growth_log by general user" do
    general_user = accounts(:general)
    assert(AccountSession.create(general_user))

    assert_no_difference('GrowthLog.count') do
      post :create, :twitter => @growth_log.attributes
    end
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not create growth_log by not user" do
    assert_no_difference('GrowthLog.count') do
      post :create, :twitter => @growth_log.attributes
    end
    assert_response 302
    assert_redirected_to new_account_session_path
  end

  ### update
  test "should update growth_log" do
    assert(AccountSession.create(accounts(:admin)))
    put :update, :id => @growth_log.to_param, :growth_log => @growth_log.attributes
    assert_redirected_to growth_log_path(assigns(:growth_log))
  end

  test "should not update my growth log by general user" do
    general_user = accounts(:one)
    assert(AccountSession.create(general_user))

    get :update, :id => @growth_log.to_param, :twitter => @growth_log.attributes
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not update by not user" do
    get :edit, :id => @growth_log.to_param
    assert_response 302
    assert_redirected_to new_account_session_path
  end

  ### destroy
  test "should destroy growth_log" do
    assert(AccountSession.create(accounts(:admin)))
    assert_difference('GrowthLog.count', -1) do
      delete :destroy, :id => @growth_log.to_param
    end

    assert_redirected_to growth_logs_path
  end

  test "should not destroy my growth_log by general user" do
    general_user = accounts(:one)
    assert(AccountSession.create(general_user))

    assert_no_difference('GrowthLog.count') do
      delete :destroy, :id => @growth_log.to_param
    end
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not destroy by not user" do
    assert_no_difference('GrowthLog.count') do
      delete :destroy, :id => @growth_log.to_param
    end
    assert_response 302
    assert_redirected_to new_account_session_path
  end
end
