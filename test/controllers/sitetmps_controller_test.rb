require 'test_helper'

class SitetmpsControllerTest < ActionController::TestCase
  setup do
    @sitetmp = sitetmps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sitetmps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sitetmp" do
    assert_difference('Sitetmp.count') do
      post :create, sitetmp: { nonce: @sitetmp.nonce }
    end

    assert_redirected_to sitetmp_path(assigns(:sitetmp))
  end

  test "should show sitetmp" do
    get :show, id: @sitetmp
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sitetmp
    assert_response :success
  end

  test "should update sitetmp" do
    patch :update, id: @sitetmp, sitetmp: { nonce: @sitetmp.nonce }
    assert_redirected_to sitetmp_path(assigns(:sitetmp))
  end

  test "should destroy sitetmp" do
    assert_difference('Sitetmp.count', -1) do
      delete :destroy, id: @sitetmp
    end

    assert_redirected_to sitetmps_path
  end
end
