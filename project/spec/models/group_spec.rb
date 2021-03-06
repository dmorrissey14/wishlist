require 'rails_helper'

test_email = 'testEmail@test.com'
test_password = 't3stPassword'
test_group_name = 'testGroup'
test_group_description = 'testGroupDescription'
test_first_name = 'testFirstName'
test_last_name = 'testLastName'

describe Group, type: :model do
  describe '#new' do
    it 'instantiates a Group object' do
      group = Group.new
      expect(group).instance_of? Group
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
      expect(Group.exists?(group.id)).to be true
    end
  end

  describe '#find' do
    it 'finds a previously stored group' do
      group = Group.create(name: test_group_name)
      group2 = Group.find(group.id)
      expect(group).to eq(group2)
    end
  end

  describe '#update' do
    it 'updates a previously stored group' do
      group = Group.create(name: test_group_name)
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
      user = User.create(email: test_email,
                         password: test_password,
                         first_name: test_first_name,
                         last_name: test_last_name)
      group = Group.create(name: test_group_name)
      group.users.push(user)
      expect(group.users).to include(user)
    end
    it 'removes user from group' do
      user = User.create(email: test_email,
                         password: test_password,
                         first_name: test_first_name,
                         last_name: test_last_name)
      group = Group.create(name: test_group_name)
      group.users.push(user)
      expect(group.users).to include(user)
      group.users.delete(user)
      expect(group.users).not_to include(user)
    end
  end
end
