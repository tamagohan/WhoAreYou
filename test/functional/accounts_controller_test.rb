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


  ### index
  test "should get index" do
    assert(AccountSession.create(accounts(:admin)))
    get :index
    assert_response :success
    assert_not_nil assigns(:accounts)
  end

  test "should not get index by not administrator" do
    get :index
    assert_response 302
    assert_redirected_to new_account_session_path
  end

  ### show
  test "should show account" do
    assert(AccountSession.create(accounts(:admin)))
    get :show, :id => @account.to_param
    assert_response :success
    assert_template :show
  end

  test "should not show other account by general user" do
    general_user = accounts(:general)
    assert(AccountSession.create(general_user))
    get :show, :id => accounts(:one).id.to_s
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not show account by not user" do
    get :show, :id => @account.to_param
    assert_response 302
    assert_redirected_to new_account_session_path
  end

  ### new
  test "should get new" do
    get :new
    assert_response :success
  end

  ### edit
  test "should get edit" do
    assert(AccountSession.create(accounts(:admin)))
    get :edit, :id => @account.to_param
    assert_response :success
  end

  test "should not get other account edit by general user" do
    general_user = accounts(:general)
    assert(AccountSession.create(general_user))

    get :edit, :id => accounts(:one).id.to_s
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not get edit by not administrator" do
    get :edit, :id => @account.to_param
    assert_response 302
    assert_redirected_to new_account_session_path
  end

  ### create
  test "should create account" do
    assert_difference('Account.count') do
      post :create, @success_create_params
    end
    assert_redirected_to new_account_session_path
  end

  test "should not create. Because password and password confirmation is diffrent" do
    assert_no_difference('Account.count') do
      @success_create_params[:account][:password_confirmation] = @success_create_params[:account][:password] + 'dummy'
      post :create, @success_create_params
    end
    assert_template :new
  end

  test "should not create without login" do
    assert_no_difference('Account.count') do
      @success_create_params[:account].delete(:login)
      post :create, @success_create_params
    end
    assert_template :new
  end

  ### update
  test "should update account" do
    assert(AccountSession.create(accounts(:admin)))
    put :update, :id => @account.to_param, :account => @account.attributes
    assert_redirected_to account_path(assigns(:account))
  end

  test "should not update other account edit by general user" do
    general_user = accounts(:general)
    assert(AccountSession.create(general_user))

    put :update, :id => @account.to_param, :account => @account.attributes
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not update account by not administrator" do
    put :update, :id => @account.to_param, :account => @account.attributes
    assert_response 302
    assert_redirected_to new_account_session_path
  end

  ### destroy
  test "should destroy account" do
    assert(AccountSession.create(accounts(:admin)))
    assert_difference('Account.count', -1) do
      delete :destroy, :id => @account.to_param
    end

    assert_redirected_to accounts_path
  end

  test "should destroy account by general user" do
    general_user = accounts(:general)
    assert(AccountSession.create(general_user))

    assert_no_difference('Account.count', -1) do
      delete :destroy, :id => @account.to_param
    end
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not destroy account by not administrator" do
    delete :destroy, :id => @account.to_param
    assert_response 302
    assert_redirected_to new_account_session_path
  end

end
