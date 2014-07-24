require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get front" do
    get :front
    assert_response :success
  end

end
