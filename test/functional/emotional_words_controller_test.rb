require 'test_helper'

class EmotionalWordsControllerTest < ActionController::TestCase
  setup do
    @emotional_word = emotional_words(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:emotional_words)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create emotional_word" do
    assert_difference('EmotionalWord.count') do
      post :create, :emotional_word => @emotional_word.attributes
    end

    assert_redirected_to emotional_word_path(assigns(:emotional_word))
  end

  test "should show emotional_word" do
    get :show, :id => @emotional_word.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @emotional_word.to_param
    assert_response :success
  end

  test "should update emotional_word" do
    put :update, :id => @emotional_word.to_param, :emotional_word => @emotional_word.attributes
    assert_redirected_to emotional_word_path(assigns(:emotional_word))
  end

  test "should destroy emotional_word" do
    assert_difference('EmotionalWord.count', -1) do
      delete :destroy, :id => @emotional_word.to_param
    end

    assert_redirected_to emotional_words_path
  end
end
