require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  setup do
    activate_authlogic
    @account = accounts(:one)
    @success_create_params = { :account =>
      { :login                 => 'test',
        :password              => 'qawsedrf',
        :password_confirmation => 'qawsedrf'
      }
    }
  end

  test "should get index" do
    assert(AccountSession.create(accounts(:admin)))
    get :index
    assert_response :success
    assert_not_nil assigns(:accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create account" do
    assert_difference('Account.count') do
      post :create, @success_create_params
    end

    assert_redirected_to account_path(assigns(:account))
  end

  test "should show account" do
    assert(AccountSession.create(accounts(:admin)))
    get :show, :id => @account.to_param
    assert_response :success
  end

  test "should get edit" do
    assert(AccountSession.create(accounts(:admin)))
    get :edit, :id => @account.to_param
    assert_response :success
  end

  test "should update account" do
    assert(AccountSession.create(accounts(:admin)))
    put :update, :id => @account.to_param, :account => @account.attributes
    assert_redirected_to account_path(assigns(:account))
  end

  test "should destroy account" do
    assert(AccountSession.create(accounts(:admin)))
    assert_difference('Account.count', -1) do
      delete :destroy, :id => @account.to_param
    end

    assert_redirected_to accounts_path
  end
end
