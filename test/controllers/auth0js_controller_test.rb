require 'test_helper'

class Auth0jsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get auth0js_show_url
    assert_response :success
  end

end
