require 'test_helper'

class ApiControllerTest < ActionController::TestCase
  test "should get page_selectors_scan" do
    get :page_selectors_scan
    assert_response :success
  end

end
