require 'test_helper'

class StaticControllerTest < ActionDispatch::IntegrationTest

  test "should get home" do
    get root_path
    assert_response :success
  end

  test "should get login" do
    get login_path
    assert_response :success
  end

  test "navbar links" do
    get root_path
    assert_template "static/home"
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", lists_path
    # need home icon link
    # need groups link
  end

end
