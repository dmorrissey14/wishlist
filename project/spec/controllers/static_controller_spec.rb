require 'rails_helper'

describe StaticController, type: :controller do
  include RSpec::Rails::RequestExampleGroup
  render_views

  it 'should get home' do
    get root_path
    assert_response :success
  end

  it 'should get login' do
    get login_path
    assert_response :success
  end

  it 'navbar links' do
    get root_path
    assert_template 'static/home'
    assert_select 'a[href=?]', login_path
    assert_select 'a[href=?]', lists_path
    # need home icon link
    # need groups link
  end
end
