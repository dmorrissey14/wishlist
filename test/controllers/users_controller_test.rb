require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should redirect on successful user creation" do
    # send a post request to user/create
    post "/users", params: { session: { email: "tester@test.com", password: "testpass" } }
    assert_response :redirect
  end

  test "should get new" do
<<<<<<< HEAD
    #get users_new_url
    #assert_response :success
  end

  test "should get show" do
    #get lists_path
    #assert_response :success
=======
    get new_user_url
    assert_response :success
  end

  test "should get show" do
    @user = users(:testuser)
    get lists_path, params: { id: @user[:id]}
    assert_response :success
>>>>>>> origin/authentication
  end
end
