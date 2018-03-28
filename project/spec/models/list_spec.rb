require 'rails_helper'

test_email = 'testEmail@test.com'
test_email2 = 'updatedtestEmail@test.com'
test_password = 'testPassword'
test_password2 = 'testPassword2'
test_group_name = 'testGroup'
test_list_name = 'testList'
test_list_description = 'testDescription'
test_first_name = 'testFirstName'
test_first_name2 = 'testFirstName2'
test_last_name = 'testLastName'
test_last_name2 = 'testLastName2'

# Rubocop complains about the block length, though this is RSpec convention.
# rubocop:disable Metrics/BlockLength
describe List, type: :model do
  before(:each) do
    @user = User.create(email: test_email, password: test_password,
                        first_name: test_first_name, last_name: test_last_name)
  end

  describe '#new' do
    it 'instantiates a List object' do
      list = List.new
      expect(list).to be_instance_of List
    end
    it 'requires validation' do
      list = List.new
      expect(list.valid?).to be false
      list.name = test_list_name
      list.owner = @user
      expect(list.valid?).to be true
    end
    it 'saves' do
      list = List.new
      list.name = test_list_name
      list.owner = @user
      expect(list.save).to be true
      expect(List.exists?(list.id)).to be true
    end
  end

  describe '#create' do
    it 'instantiates and stores a List object' do
      list = List.create(name: test_list_name, owner: @user)
      expect(list).to be_instance_of List
      expect(List.exists?(list.id)).to be true
    end
  end

  describe '#find' do
    it 'retrieves a previously stored list' do
      list = List.create(name: test_list_name, owner: @user)
      expect(List.exists?(list.id)).to be true
      list2 = List.find(list.id)
      expect(list).to eq(list2)
    end
  end

  describe '#update' do
    it 'updates a previously stored list' do
      list = List.create(name: test_list_name, owner: @user)
      expect(List.exists?(list.id)).to be true
      list.update(description: test_list_description)
      expect(list.description).to eq(test_list_description)
    end
  end

  describe '#destroy' do
    it 'deletes a previously stored list' do
      list = List.create(name: test_list_name, owner: @user)
      expect(List.exists?(list.id)).to be true
      list.destroy
      expect(List.exists?(list.id)).to be false
    end
  end

  describe '#owner?' do
    it 'determines if a user is the owner of a list' do
      list = List.create(name: test_list_name, owner: @user)
      expect(List.exists?(list.id)).to be true
      user2 = User.create(email: test_email2, password: test_password2, first_name: test_first_name2, last_name: test_last_name2)
      expect(User.exists?(user2.id)).to be true
      expect(list.owner?(@user)).to be true
      expect(list.owner?(user2)).to be false
    end
  end

  describe '#viewer?' do
    it 'determines if a user is a viewer of a list' do
      list = List.create(name: test_list_name, owner: @user)
      expect(List.exists?(list.id)).to be true
      group = Group.create(name: test_group_name)
      list.groups.push(group)
      expect(list.groups).to include(group)
      user2 = User.create(email: test_email2, password: test_password2, first_name: test_first_name2, last_name: test_last_name2)
      expect(User.exists?(user2.id)).to be true
      expect(list.viewer?(@user)).to be true
      expect(list.viewer?(user2)).to be false
      group.users.push(user2)
      expect(list.viewer?(user2)).to be true
    end
  end
end
# rubocop:enable Metrics/BlockLength
