require 'test_helper'

class AvatarsControllerTest < ActionController::TestCase
  setup do
    activate_authlogic
    @avatar = avatars(:one)
    @success_create_params = { :avatar => { :name => 'test' } }
  end


  ### index
  test "should get index" do
    assert(AccountSession.create(accounts(:admin)))
    get :index
    assert_response :success
    assert_not_nil assigns(:avatars)
  end

  test "should not get index by not administrator" do
    get :index
    assert_response 302
    assert_redirected_to new_account_session_path
  end

  ### show
  test "should show avatar" do
    assert(AccountSession.create(accounts(:admin)))
    get :show, :id => @avatar.id
    assert_response :success
    assert_template :show
  end

  test "should show my avatar by general user" do
    general_user = accounts(:one)
    assert(AccountSession.create(general_user))

    get :show, :id => @avatar.to_param
    assert_response :success
    assert_template :show
  end

  test "should not show other's avatar by general user" do
    general_user = accounts(:general)
    assert(AccountSession.create(general_user))

    get :show, :id => @avatar.to_param
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not show avatar by not administrator" do
    get :show, :id => @avatar.to_param
    assert_response 302
    assert_redirected_to new_account_session_path
  end

  ### new
  test "should get new" do
    assert(AccountSession.create(accounts(:general)))
    get :new
    assert_response :success
    assert_template :new
  end

  test "should get new by general user" do
    general_user = accounts(:general)
    assert(AccountSession.create(general_user))

    get :new
    assert_response :success
    assert_template :new
  end

  ### edit
  test "should get edit" do
    assert(AccountSession.create(accounts(:admin)))
    get :edit, :id => @avatar.to_param
    assert_response :success
    assert_template :edit
  end

   test "should get edit my avatar by general user" do
    general_user = accounts(:one)
    assert(AccountSession.create(general_user))

    get :edit, :id => @avatar.to_param
    assert_response :success
    assert_template :edit
   end

  test "should not edit other's avatar by general user" do
    general_user = accounts(:general)
    assert(AccountSession.create(general_user))

    get :edit, :id => @avatar.to_param
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not get edit by not user" do
    get :edit, :id => @avatar.to_param
    assert_response 302
    assert_redirected_to new_account_session_path
  end

  ### create
  test "should create avatar" do
    assert(AccountSession.create(accounts(:general)))
    assert_difference('Avatar.count') do
      post :create, :avatar => @avatar.attributes
    end

    assert_redirected_to avatar_path(assigns(:avatar))
  end

  test "should create first avatar" do
    general_user = accounts(:general)
    assert(AccountSession.create(general_user))
    assert_nil general_user.avatar

    assert_difference('Avatar.count') do
      post :create, @success_create_params
    end
    assert_redirected_to avatar_path(assigns(:avatar))
  end

  # TODO this function unimplemented
  test "should not create second avatar" do
    general_user = accounts(:general)
    assert(AccountSession.create(general_user))

    assert_difference('Avatar.count') do
      post :create, @success_create_params
    end
    assert_redirected_to avatar_path(assigns(:avatar))
    assert_equal 1, Avatar.find_all_by_account_id(general_user.id).count

#     assert_no_difference('Avatar.count') do
#       post :create, @success_create_params
#     end
  end

  test "should not create avatar by not user" do
    assert_no_difference('Avatar.count') do
      post :create, @success_create_params
    end
    assert_response 302
    assert_redirected_to new_account_session_path
  end

  ### update
  test "should update avatar" do
    assert(AccountSession.create(accounts(:admin)))
    put :update, :id => @avatar.to_param, :avatar => @avatar.attributes
    assert_redirected_to avatar_path(assigns(:avatar))
  end

  test "should update my avatar by general user" do
    general_user = accounts(:one)
    assert(AccountSession.create(general_user))

    put :update, :id => @avatar.to_param, :avatar => @avatar.attributes
    assert_redirected_to avatar_path(assigns(:avatar))
  end

  test "should not update other's avatar by general user" do
    general_user = accounts(:general)
    assert(AccountSession.create(general_user))

    put :update, :id => @avatar.to_param, :avatar => @avatar.attributes
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not update avatar by not administrator" do
    put :update, :id => @avatar.to_param, :avatar => @avatar.attributes
    assert_response 302
    assert_redirected_to new_account_session_path
  end

  ### destroy
  test "should destroy avatar" do
    assert(AccountSession.create(accounts(:admin)))
    assert_difference('Avatar.count', -1) do
      delete :destroy, :id => @avatar.to_param
    end

    assert_redirected_to avatars_path
  end

  test "should not destroy other's avatar by general user" do
    general_user = accounts(:general)
    assert(AccountSession.create(general_user))

    assert_no_difference('Avatar.count', -1) do
      delete :destroy, :id => @avatar.to_param
    end
    assert_response 302
    assert_redirected_to account_path(general_user)
  end

  test "should not destroy avatar by not administrator" do
    assert_no_difference('Avatar.count', -1) do
      delete :destroy, :id => @avatar.to_param
    end

    assert_response 302
    assert_redirected_to new_account_session_path
  end

end
