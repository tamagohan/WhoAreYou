require 'test_helper'

class GrowthLogsControllerTest < ActionController::TestCase
  setup do
    @growth_log = growth_logs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:growth_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create growth_log" do
    assert_difference('GrowthLog.count') do
      post :create, :growth_log => @growth_log.attributes
    end

    assert_redirected_to growth_log_path(assigns(:growth_log))
  end

  test "should show growth_log" do
    get :show, :id => @growth_log.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @growth_log.to_param
    assert_response :success
  end

  test "should update growth_log" do
    put :update, :id => @growth_log.to_param, :growth_log => @growth_log.attributes
    assert_redirected_to growth_log_path(assigns(:growth_log))
  end

  test "should destroy growth_log" do
    assert_difference('GrowthLog.count', -1) do
      delete :destroy, :id => @growth_log.to_param
    end

    assert_redirected_to growth_logs_path
  end
end
