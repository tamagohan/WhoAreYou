require 'test_helper'

class IndexControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get oauth" do
    get :oauth
    assert_response :success
  end

  test "should get callback" do
    get :callback
    assert_response :success
  end

end
