require 'rails_helper'

describe UsersController, type: :controller do
  include RSpec::Rails::RequestExampleGroup

  it 'should redirect on successful user creation' do
    # send a post request to user/create
    post '/signup', params: { session: { email: 'tester999@test.com',
                                         password: 'T3stpass',
                                         password_confirmation: 'T3stpass',
                                         first_name: 'TestFirst',
                                         last_name: 'TestLast' } }
    assert_response :redirect
  end

  it 'should get new' do
    get new_user_url
    assert_response :success
  end

  it 'should block show if there is no logged in user' do
    get lists_path
    assert_response :redirect
  end
end
