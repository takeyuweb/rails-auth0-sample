require 'test_helper'

class DeviseSampleControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get devise_sample_show_url
    assert_response :success
  end

end
