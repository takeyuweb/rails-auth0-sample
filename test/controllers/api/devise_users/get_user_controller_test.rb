require 'test_helper'

class Api::DeviseUsers::GetUserControllerTest < ActionDispatch::IntegrationTest
  fixtures :devise_users

  test 'should get show' do
    user = devise_users(:one)

    get api_devise_users_get_user_path, params: { email: user.email }
    assert_response :success
    assert_equal user.id, response.parsed_body['user_id']
    assert_equal user.email, response.parsed_body['email']

    get api_devise_users_get_user_path, params: { email: 'invalid@test.host' }
    assert_response :not_found
  end

end
