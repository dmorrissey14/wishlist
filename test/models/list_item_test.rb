require 'test_helper'

# Unit tests for the ListItem model
class ListItemTest < ActiveSupport::TestCase
  # Reusable test parameters
  test_email = 'testEmail'
  test_password = 'testPassword'
  test_list_name = 'testList'
  test_list_item_description = 'testItem'
  test_list_item_comments = 'testComments'

  # Additional setup performed before each unit test.
  setup do
    @user = User.create(test_email, test_password)
    @list = List.create(name: test_list_name, user: @user)
  end

  # Verifies a ListItem can be created using the ListItem.new() method.
  test 'create list item using new' do
    item = ListItem.new
    assert_not_nil item
    assert_not item.valid?
    item.description = test_list_item_description
    item.list = @list
    assert item.valid?
    assert item.save
    assert ListItem.exists?(item.id)
  end

  # Verifies a ListItem can be created using the ListItem.create() method.
  test 'create list item using create' do
    item = ListItem.create(description: test_list_item_description, list: @list)
    assert_not_nil item
    assert ListItem.exists?(item.id)
  end

  # Verifies a created ListItem can be retrieved from the database.
  test 'retrieve list item from database' do
    item = ListItem.create(description: test_list_item_description, list: @list)
    assert_not_nil item
    assert ListItem.exists?(item.id)
    item2 = ListItem.find(item.id)
    assert_equal(item, item2)
  end

  # Verifies ListItem attributes can be updated via the update() method.
  test 'update list item' do
    item = ListItem.create(description: test_list_item_description, list: @list)
    assert ListItem.exists?(item.id)
    item.update(comments: test_list_item_comments)
    assert_equal(item.comments, test_list_item_comments)
  end

  # Verifies a ListItem can be deleted from the database.
  test 'delete list item' do
    item = ListItem.create(description: test_list_item_description, list: @list)
    assert ListItem.exists?(item.id)
    item.destroy
    assert_not ListItem.exists?(item.id)
  end
end
