require 'rails_helper'

describe SessionsController, type: :controller do
  include RSpec::Rails::RequestExampleGroup

  it 'should redirect when given correct login info' do
    post '/login', params: { session: { email: 'user@test.com',
                                        password: 'T3stpass' } }

    # post(:login, :session => {:email => 'user@test.com', :password => 'T3stpass'})
    assert_response :redirect
    #expect(response).to render_template('/users/show')
  end
end
