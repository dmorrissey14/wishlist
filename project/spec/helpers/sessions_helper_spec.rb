require 'rails_helper'

describe SessionsHelper, type: :helper do
  fixtures :users

  it 'session helper functions work' do
    @user = users(:testuser)
    log_in @user
    expect(logged_in?).to be true

    @user2 = current_user
    expect(@user).to eq(@user2)

    log_out
    expect(logged_in?).to be false

    expect(BCrypt::Password.new(@user[:password_hash])
      .is_password?('T3stpass')).to be true
  end
end
