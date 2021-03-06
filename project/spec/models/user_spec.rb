require 'rails_helper'

test_email = 'testEmail@test.com'
test_email2 = 'updatedtestEmail@test.com'
test_password = 't3stPassword1'
test_password2 = 't3stPassword2'
test_first_name = 'John'
test_last_name = 'Doe'
test_group_name = 'testGroup'
test_first_name2 = 'testFirstName2'
test_last_name2 = 'testLastName2'

describe User, type: :model do
  include SessionsHelper

  describe '#new' do
    it 'takes email and password unhashed' do
      user = User.new(email: test_email, password: test_password,
                      first_name: test_first_name, last_name: test_last_name)
      expect(user).instance_of? User
    end
    it 'is valid' do
      user = User.new(email: test_email, password: test_password,
                      first_name: test_first_name, last_name: test_last_name)
      expect(user.valid?).to be true
    end
    it 'saves' do
      user = User.new(email: test_email, password: test_password,
                      first_name: test_first_name, last_name: test_last_name)
      expect(user.save).to be true
    end
    it 'is retrievable after saving' do
      user = User.new(email: test_email, password: test_password,
                      first_name: test_first_name, last_name: test_last_name)
      user.save
      expect(User.exists?(user.id)).to be true
    end
  end

  describe '#create' do
    it 'takes email and password unhashed' do
      user = User.create(email: test_email, password: test_password,
                         first_name: test_first_name, last_name: test_last_name)
      expect(user).instance_of? User
    end
    it 'is valid' do
      user = User.create(email: test_email, password: test_password,
                         first_name: test_first_name, last_name: test_last_name)
      expect(user.valid?).to be true
    end
    it 'is retrievable after creation' do
      user = User.create(email: test_email, password: test_password,
                         first_name: test_first_name, last_name: test_last_name)
      expect(User.exists?(user.id)).to be true
    end
  end

  describe '#find' do
    it 'can be found by ID' do
      user = User.create(email: test_email, password: test_password,
                         first_name: test_first_name, last_name: test_last_name)
      expect(User.exists?(user.id)).to be true
      user2 = User.find(user.id)
      expect(user).to eq(user2)
    end
    it 'can retrieve first and last name' do
      user = User.create(email: test_email, password: test_password,
                         first_name: test_first_name, last_name: test_last_name)
      user2 = User.find(user.id)
      expect(user2.first_name).to eq(test_first_name)
      expect(user2.last_name).to eq(test_last_name)
    end
  end

  describe '#update' do
    it 'user name can be updated' do
      user = User.create(email: test_email, password: test_password,
                         first_name: test_first_name, last_name: test_last_name)
      expect(User.exists?(user.id)).to be true
      user.update(first_name: test_first_name2, last_name: test_last_name2)
      expect(user.first_name).to eq(test_first_name2)
      expect(user.last_name).to eq(test_last_name2)
    end
    it 'email can be updated' do
      user = User.create(email: test_email, password: test_password,
                         first_name: test_first_name, last_name: test_last_name)
      expect(User.exists?(user.id)).to be true
      user.update(email: test_email2)
      expect(user.email).to eq(test_email2.downcase)
      expect(BCrypt::Password.new(user.password_hash).is_password?(test_password)).to be true
    end
    it 'password can be updated' do
      user = User.create(email: test_email, password: test_password,
                         first_name: test_first_name, last_name: test_last_name)
      expect(User.exists?(user.id)).to be true
      user.update(password: test_password2)
      expect(user.password).to eq(test_password2)
      expect(BCrypt::Password.new(user.password_hash).is_password?(test_password2)).to be true
    end
  end

  describe '#destroy' do
    it 'can be deleted' do
      user = User.create(email: test_email, password: test_password,
                         first_name: test_first_name, last_name: test_last_name)
      expect(User.exists?(user.id)).to be true
      user.destroy
      expect(User.exists?(user.id)).to be false
    end
  end

  describe '#groups' do
    it 'can be added to group' do
      user = User.create(email: test_email, password: test_password,
                         first_name: test_first_name, last_name: test_last_name)
      expect(User.exists?(user.id)).to be true
      group = Group.create(name: test_group_name)
      expect(Group.exists?(group.id)).to be true
      user.groups.push(group)
      expect(user.groups).to include(group)
    end
    it 'can be removed from group' do
      user = User.create(email: test_email, password: test_password,
                         first_name: test_first_name, last_name: test_last_name)
      expect(User.exists?(user.id)).to be true
      group = Group.create(name: test_group_name)
      expect(Group.exists?(group.id)).to be true
      user.groups.push(group)
      expect(user.groups).to include(group)
      user.groups.delete(group)
      expect(user.groups).not_to include(group)
    end
  end

  describe '#full_name' do
    it 'returns the full name of the user' do
      user = User.create(email: test_email, password: test_password,
                         first_name: test_first_name, last_name: test_last_name)
      expect(user.full_name).to eq('John Doe')
    end
  end

  describe '#display_string' do
    it 'contains the full name of the user' do
      user = User.create(email: test_email, password: test_password,
                         first_name: test_first_name, last_name: test_last_name)
      expect(user.display_string.include?(user.full_name)).to be true
    end
    it 'contains the ID of the user' do
      user = User.create(email: test_email, password: test_password,
                         first_name: test_first_name, last_name: test_last_name)
      expect(user.display_string.include?(user.id.to_s)).to be true
    end
  end
end
