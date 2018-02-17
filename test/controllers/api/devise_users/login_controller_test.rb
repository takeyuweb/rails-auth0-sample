require 'test_helper'

class Api::DeviseUsers::LoginControllerTest < ActionDispatch::IntegrationTest
  fixtures :users

  test 'should get show' do
    user = users(:one)

    get api_devise_users_login_path, params: { email: user.email, password: 'one' }
    assert_response :success
    assert_equal user.id, response.parsed_body['user_id']
    assert_equal user.email, response.parsed_body['email']


    get api_devise_users_login_path, params: { email: user.email, password: 'invalid' }
    assert_response :not_found

    get api_devise_users_login_path, params: { email: 'invalid@test.host', password: 'invalid' }
    assert_response :not_found
  end

end
