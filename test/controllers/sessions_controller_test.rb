require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should redirect when given correct login info" do
    post "/login", params: { session: { email: "test65@test.com", password: "testpass" } }
    assert_response :redirect
  end
end
