require 'rails_helper'

describe SessionsController, type: :controller do
  include RSpec::Rails::RequestExampleGroup

  it 'can redirect when given correct login info' do
    post '/login', params: { session: { email: 'user@test.com',
                                        password: 'T3stpass' } }
    expect(response).to redirect_to('/lists')
  end

  it 'does not redirect when given false login info' do
    post '/login', params: { session: { email: 'user@tekjhkjhst.com',
                                        password: 'T3stpass' } }
    expect(response).to render_template('new');
  end
end
