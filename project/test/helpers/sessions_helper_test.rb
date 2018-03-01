require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
  test "session helper functions work" do
    @user = users(:testuser)
    log_in @user
    assert logged_in?

    @user2 = current_user
    assert_equal(@user, @user2)

    log_out
    assert !logged_in?

    hashed_pw = calculate_hash("testpass")
    assert_equal(@user[:password_hash], hashed_pw)
  end
end
