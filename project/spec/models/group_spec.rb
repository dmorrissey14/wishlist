require 'rails_helper'

test_email = 'testEmail@test.com'
test_password = 'testPassword'
test_group_name = 'testGroup'
test_group_description = 'testGroupDescription'

# Rubocop complains about the block length, though this is RSpec convention.
# rubocop:disable Metrics/BlockLength
describe Group, type: :model do
  describe '#new' do
    it 'instantiates a Group object' do
      group = Group.new
      expect(group).to be_instance_of Group
    end
    it 'requires a group name for validation' do
      group = Group.new
      expect(group.valid?).to be false
      group.name = test_group_name
      expect(group.valid?).to be true
    end
    it 'can be saved to database' do
      group = Group.new
      group.name = test_group_name
      expect(group.save).to be true
    end
  end

  describe '#create' do
    it 'instantiates and stores a Group object' do
      group = Group.create(name: test_group_name)
      expect(group).to be_instance_of Group
      expect(Group.exists?(group.id)).to be true
    end
  end

  describe '#find' do
    it 'finds a previously stored group' do
      group = Group.create(name: test_group_name)
      expect(Group.exists?(group.id)).to be true
      group2 = Group.find(group.id)
      expect(group).to eq(group2)
    end
  end

  describe '#update' do
    it 'updates a previously stored group' do
      group = Group.create(name: test_group_name)
      expect(Group.exists?(group.id)).to be true
      group.update(description: test_group_description)
      expect(group.description).to eq(test_group_description)
    end
  end

  describe '#destroy' do
    it 'deletes a previously stored group' do
      group = Group.create(name: test_group_name)
      expect(Group.exists?(group.id)).to be true
      group.destroy
      expect(Group.exists?(group.id)).to be false
    end
  end

  describe '#users' do
    it 'adds user to group' do
      user = User.create(test_email, test_password)
      expect(User.exists?(user.id)).to be true
      group = Group.create(name: test_group_name)
      expect(Group.exists?(group.id)).to be true
      group.users.push(user)
      expect(group.users).to include(user)
    end
    it 'removes user group goup' do
      user = User.create(test_email, test_password)
      expect(User.exists?(user.id)).to be true
      group = Group.create(name: test_group_name)
      expect(Group.exists?(group.id)).to be true
      group.users.push(user)
      expect(group.users).to include(user)
      group.users.delete(user)
      expect(group.users).not_to include(user)
    end
  end
end
# rubocop:enable Metrics/BlockLength
