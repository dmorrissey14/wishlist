require 'rails_helper'

test_email = 'testEmail@test.com'
test_email2 = 'updatedtestEmail@test.com'
test_password = 'testPassword'
test_password2 = 'testPassword2'
test_first_name = 'John'
test_last_name = 'Doe'
test_group_name = 'testGroup'

# Rubocop complains about the block length, though this is RSpec convention.
# rubocop:disable Metrics/BlockLength
describe User, type: :model do
  include SessionsHelper

  describe '#new' do
    it 'takes email and password unhashed' do
      user = User.new(test_email, test_password)
      expect(user).to be_an_instance_of User
    end
    it 'is valid' do
      user = User.new(test_email, test_password)
      expect(user).to be_valid
    end
    it 'saves' do
      user = User.new(test_email, test_password)
      expect(user.save).to be true
    end
    it 'is retrievable after saving' do
      user = User.new(test_email, test_password)
      user.save
      expect(User.exists?(user.id)).to be true
    end
  end

  describe '#create' do
    it 'takes email and password unhashed' do
      user = User.create(test_email, test_password)
      expect(user).to be_an_instance_of User
    end
    it 'is valid' do
      user = User.create(test_email, test_password)
      expect(user).to be_valid
    end
    it 'is retrievable after creation' do
      user = User.create(test_email, test_password)
      expect(User.exists?(user.id)).to be true
    end
  end

  describe '#find' do
    it 'can be found by ID' do
      user = User.create(test_email, test_password)
      expect(User.exists?(user.id)).to be true
      user2 = User.find(user.id)
      expect(user).to eq(user2)
    end
  end

  describe '#update' do
    it 'can be updated' do
      user = User.create(test_email, test_password)
      expect(User.exists?(user.id)).to be true
      user.update(first_name: test_first_name, last_name: test_last_name)
      expect(user.first_name).to eq(test_first_name)
      expect(user.last_name).to eq(test_last_name)
    end
    it 'email can be updated' do
      user = User.create(test_email, test_password)
      expect(User.exists?(user.id)).to be true
      user.update(email: test_email2)
      expect(user.email).to eq(test_email2)
      expect(user.email_hash).to eq(calculate_hash(test_email2))
    end
    it 'password can be updated' do
      user = User.create(test_email, test_password)
      expect(User.exists?(user.id)).to be true
      user.update(password: test_password2)
      expect(user.password).to eq(test_password2)
      expect(user.password_hash).to eq(calculate_hash(test_password2))
    end
  end

  describe '#destroy' do
    it 'can be deleted' do
      user = User.create(test_email, test_password)
      expect(User.exists?(user.id)).to be true
      user.destroy
      expect(User.exists?(user.id)).to be false
    end
  end

  describe '#groups' do
    it 'can be added to group' do
      user = User.create(test_email, test_password)
      expect(User.exists?(user.id)).to be true
      group = Group.create(name: test_group_name)
      expect(Group.exists?(group.id)).to be true
      user.groups.push(group)
      expect(user.groups).to include(group)
    end
    it 'can be removed from group' do
      user = User.create(test_email, test_password)
      expect(User.exists?(user.id)).to be true
      group = Group.create(name: test_group_name)
      expect(Group.exists?(group.id)).to be true
      user.groups.push(group)
      expect(user.groups).to include(group)
      user.groups.delete(group)
      expect(user.groups).not_to include(group)
    end
  end

  describe '#new_anonymous_user' do
    it 'can create anonymous user' do
      user = User.new_anonymous_user
      expect(user.email).to eq('')
      expect(user.password).to eq('')
    end
    it 'is not valid' do
      user = User.new_anonymous_user
      expect(user.valid?).to be false
    end
  end
end
# rubocop:enable Metrics/BlockLength
