require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should redirect on successful user creation" do
    # send a post request to user/create
    post "/signup", params: { session: { email: "tester999@test.com", password: "testpass", password_confirmation: "testpass" } }
    assert_response :redirect
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should block show if there is no logged in user" do
    get lists_path
    assert_response :redirect
  end
end
