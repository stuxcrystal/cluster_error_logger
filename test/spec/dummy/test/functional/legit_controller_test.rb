require 'test_helper'

class LegitControllerTest < ActionController::TestCase
  test "should get passing_method" do
    get :passing_method
    assert_response :success
  end

end
