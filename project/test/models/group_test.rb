require 'test_helper'

# Unit tests for the Group model
class GroupTest < ActiveSupport::TestCase
  # Reusable test parameters
  test_email = 'testEmail@test.com'
  test_password = 'testPassword'
  test_group_name = 'testGroup'
  test_group_description = 'testGroupDescription'

  # Verifies a Group can be created using the Group.new() method.
  test 'create group using new' do
    group = Group.new
    group.name = test_group_name
    assert_not_nil group
    assert group.valid?
    assert group.save
  end

  # Verifies a Group can be created using the Group.create() method.
  test 'create group using create' do
    group = Group.create(name: test_group_name)
    assert_not_nil group
    assert Group.exists?(group.id)
  end

  # Verifies a created Group can be retrieved from the database.
  test 'retrieve group from database' do
    group = Group.create(name: test_group_name)
    assert_not_nil group
    assert Group.exists?(group.id)
    group2 = Group.find(group.id)
    assert_equal(group, group2)
  end

  # Verifies Group attributes can be updated via the update() method.
  test 'update group' do
    group = Group.create(name: test_group_name)
    assert Group.exists?(group.id)
    group.update(description: test_group_description)
    assert_equal(group.description, test_group_description)
  end

  # Verifies a Group can be deleted from the database.
  test 'delete group' do
    group = Group.create(name: test_group_name)
    assert Group.exists?(group.id)
    group.destroy
    assert_not Group.exists?(group.id)
  end

  # Verifies a Group can be associated to a user.
  test 'add user to group' do
    user = User.create(test_email, test_password)
    assert User.exists?(user.id)
    group = Group.create(name: test_group_name)
    assert Group.exists?(group.id)
    group.users.push(user)
    assert_includes(group.users, user)
  end

  # Verifies a Group can be removed from a user.
  test 'remove user from group' do
    user = User.create(test_email, test_password)
    assert User.exists?(user.id)
    group = Group.create(name: test_group_name)
    assert Group.exists?(group.id)
    group.users.push(user)
    assert_includes(group.users, user)
    group.users.delete(user)
    assert_not_includes(group.users, user)
  end
end
