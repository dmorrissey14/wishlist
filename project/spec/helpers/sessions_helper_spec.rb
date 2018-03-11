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

    hashed_pw = calculate_hash('testpass')
    expect(@user[:password_hash]).to eq(hashed_pw)
  end
end
