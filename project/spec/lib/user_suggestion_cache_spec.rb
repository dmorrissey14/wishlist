require 'rails_helper'
require 'user_suggestion_cache'

test_email_format = 'cache%<index>stest@test.com'
test_password = 't3stPassword'
test_first_name_format = 'FirstNameTest%<index>s'
test_last_name_format = 'LastNameTest%<index>s'
test_group_name_format = 'TestGroup%<index>s'
test_email2 = 'updatedtestEmail@test.com'
test_password2 = 't3stPassword2'
test_first_name2 = 'testFirstName2'
test_last_name2 = 'testLastName2'

describe UserSuggestionCache do
  before do
    groups = []
    (0..10).each do |i|
      group = Group.create(name: format(test_group_name_format, index: i))
      groups.push(group)
      @start_group_index = group.id if i.zero?
    end
    (0..20).each do |i|
      user = User.create(email: format(test_email_format, index: i),
                         password: test_password,
                         first_name: format(test_first_name_format, index: i),
                         last_name: format(test_last_name_format, index: i))
      groups[i % 2].users.push(user)
      @start_user_index = user.id if i.zero?
    end
  end

  describe '#new' do
    it 'can instantiate a new UserSuggestionCache' do
      user = User.find(@start_user_index)
      cache = described_class.new(user)
      expect(cache).instance_of? described_class
    end
  end

  describe '#initialized?' do
    it 'can initialize' do
      user = User.find(@start_user_index)
      cache = described_class.new(user)
      expect(cache.initialized?).to be true
    end
  end

  describe '#suggest_users' do
    it 'works' do
      user = User.find(@start_user_index)
      cache = described_class.new(user)
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
      cache = described_class.new(user)
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
