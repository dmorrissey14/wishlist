require 'rails_helper'
require 'user_suggestion_cache'

test_email_format = 'cache%<index>stest@test.com'
test_password = 'testpassword'
test_first_name_format = 'FirstNameTest%<index>s'
test_last_name_format = 'LastNameTest%<index>s'
test_group_name_format = 'TestGroup%<index>s'
test_email2 = 'updatedtestEmail@test.com'
test_password2 = 'testPassword2'
test_first_name2 = 'testFirstName2'
test_last_name2 = 'testLastName2'

# Rubocop complains about the block length, though this is RSpec convention.
# rubocop:disable Metrics/BlockLength
describe UserSuggestionCache do
  before(:all) do
    groups = []
    (0..10).each do |i|
      group = Group.create(name: format(test_group_name_format, index: i))
      groups.push(group)
      @start_group_index = group.id if i == 0
    end
    (0..100).each do |i|
      user = User.create(email: format(test_email_format, index: i),
                         password: test_password,
                         first_name: format(test_first_name_format, index: i),
                         last_name: format(test_last_name_format, index: i))
      groups[i % 10].users.push(user)
      @start_user_index = user.id if i == 0
    end
  end

  describe '#new' do
    it 'can instantiate a new UserSuggestionCache' do
      user = User.find(@start_user_index)
      expect(user).to be_instance_of(User)
      cache = UserSuggestionCache.new(user)
      expect(cache).to be_instance_of(UserSuggestionCache)
    end
  end

  describe '#initialized?' do
    it 'can initialize' do
      user = User.find(@start_user_index)
      expect(user).to be_instance_of(User)
      cache = UserSuggestionCache.new(user)
      expect(cache.initialized?).to be true
    end
  end

  describe '#suggest_users' do
    it 'works' do
      user = User.find(@start_user_index)
      cache = UserSuggestionCache.new(user)
      group = Group.find(@start_group_index)
      cache.suggest_users('test').each do |su|
        expect(group.users).to include(su)
      end
      cache.suggest_users('test1').each do |su|
        expect(group.users).to include(su)
      end
    end
  end

  describe '#refresh' do
    it 'refreshes the cache contents' do
      user = User.find(@start_user_index)
      cache = UserSuggestionCache.new(user)
      group = Group.find(@start_group_index)
      cache.suggest_users('test').each do |su|
        expect(group.users).to include(su)
      end
      cache.suggest_users('test1').each do |su|
        expect(group.users).to include(su)
      end
      user2 = User.create(email: test_email2,
                          password: test_password2,
                          first_name: test_first_name2,
                          last_name: test_last_name2)
      group.users.push(user2)
      expect(cache.last_results).not_to include(user2)
      cache.refresh
      expect(cache.suggest_users('test').include?(user2)).to be true
    end
  end
end
# rubocop:enable Metrics/BlockLength
