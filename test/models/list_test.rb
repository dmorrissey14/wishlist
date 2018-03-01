require 'test_helper'

# Unit tests for the List model
class ListTest < ActiveSupport::TestCase
  # Reusable test parameters
  test_email = 'testEmail@test.com'
  test_password = 'testPassword'
  test_list_name = 'testList'
  test_list_description = 'testDescription'

  # Additional setup performed before each unit test.
  setup do
    @user = User.create(test_email, test_password)
  end

  # Verifies a List can be created using the List.new() method.
  test 'create list using new' do
    list = List.new
    assert_not_nil list
    list.name = test_list_name
    list.owner = @user
    assert list.valid?
    assert list.save
    assert List.exists?(list.id)
  end

  # Verifies a List can be created using the List.create() method.
  test 'create list using create' do
    list = List.create(name: test_list_name, owner: @user)
    assert_not_nil list
    assert List.exists?(list.id)
  end

  # Verifies a created List can be retrieved from the database.
  test 'retrieve list from database' do
    list = List.create(name: test_list_name, owner: @user)
    assert_not_nil list
    assert List.exists?(list.id)
    list2 = List.find(list.id)
    assert_equal(list, list2)
  end

  # Verifies List attributes can be updated via the update() method.
  test 'update list' do
    list = List.create(name: test_list_name, owner: @user)
    assert List.exists?(list.id)
    list.update(description: test_list_description)
    assert_equal(list.description, test_list_description)
  end

  # Verifies a List can be deleted from the database.
  test 'delete list' do
    list = List.create(name: test_list_name, owner: @user)
    assert List.exists?(list.id)
    list.destroy
    assert_not List.exists?(list.id)
  end
end
