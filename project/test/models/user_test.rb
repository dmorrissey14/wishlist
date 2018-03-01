require 'test_helper'

# Unit tests for the User model
class UserTest < ActiveSupport::TestCase
  # Reusable test parameters
  test_email = 'testEmail'
  test_password = 'testPassword'
  test_first_name = 'John'
  test_last_name = 'Doe'
  test_group_name = 'testGroup'

  # Verifies a User can be created using the User.new() method.
  test 'create user using new' do
    # Make sure a user can be created using new()
    user = User.new(test_email, test_password)
    assert_not_nil user
    assert user.valid?
    assert user.save
    assert User.exists?(user.id)
  end

  # Verifies a User can be created using the User.create() method.
  test 'create user using create' do
    # Make sure a user can be created using create()
    user = User.create(test_email, test_password)
    assert_not_nil user
    assert User.exists?(user.id)
  end

  # Verifies a created user can be retrieved from the database.
  test 'retrieve user from database' do
    user = User.create(test_email, test_password)
    assert User.exists?(user.id)
    user2 = User.find(user.id)
    assert_equal(user, user2)
  end

  # Verifies user attributes can be updated via the update() method.
  test 'update user' do
    user = User.create(test_email, test_password)
    assert User.exists?(user.id)
    user.update(first_name: test_first_name, last_name: test_last_name)
    assert_equal(user.first_name, test_first_name)
    assert_equal(user.last_name, test_last_name)
  end

  # Verifies a user can be deleted from the database.
  test 'delete user' do
    user = User.create(test_email, test_password)
    assert User.exists?(user.id)
    user.destroy
    assert_not User.exists?(user.id)
  end

  # Verifies a group can be associated to a user.
  test 'add group to user' do
    user = User.create(test_email, test_password)
    assert User.exists?(user.id)
    group = Group.create(name: test_group_name)
    assert Group.exists?(group.id)
    user.groups.push(group)
    assert_includes(user.groups, group)
  end

  # Verifies a group can be removed from a user.
  test 'remove group from user' do
    user = User.create(test_email, test_password)
    assert User.exists?(user.id)
    group = Group.create(name: test_group_name)
    assert Group.exists?(group.id)
    user.groups.push(group)
    assert_includes(user.groups, group)
    user.groups.delete(group)
    assert_not_includes(user.groups, group)
  end
end
