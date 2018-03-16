require 'rails_helper'

test_email = 'testEmail@test.com'
test_password = 'testPassword'
test_list_name = 'testList'
test_description = 'testItem'
test_list_item_comments = 'testComments'
test_first_name = 'testFirstName'
test_last_name = 'testLastName'

# Rubocop complains about the block length, though this is RSpec convention.
# rubocop:disable Metrics/BlockLength
describe ListItem, type: :model do
  before(:each) do
    @user = User.create(email: test_email, password: test_password, first_name: test_first_name, last_name: test_last_name)
    @list = List.create(name: test_list_name, user: @user)
  end

  describe '#new' do
    it 'instantiates a ListItem object' do
      item = ListItem.new
      expect(item).to be_instance_of ListItem
      expect(item.valid?).to be false
      item.description = test_description
      item.list = @list
      expect(item.valid?).to be true
      expect(item.save).to be true
      expect(ListItem.exists?(item.id)).to be true
    end
  end

  describe '#create' do
    it 'instantiates and stores a ListItem object' do
      item = ListItem.create(description: test_description, list: @list)
      expect(item).to be_instance_of ListItem
      expect(ListItem.exists?(item.id)).to be true
    end
  end

  describe '#find' do
    it 'retrieves a previously stored list item' do
      item = ListItem.create(description: test_description, list: @list)
      expect(ListItem.exists?(item.id)).to be true
      item2 = ListItem.find(item.id)
      expect(item).to eq(item2)
    end
  end

  describe '#update' do
    it 'updates a previously stored list item' do
      item = ListItem.create(description: test_description, list: @list)
      expect(ListItem.exists?(item.id)).to be true
      item.update(comments: test_list_item_comments)
      expect(item.comments).to eq(test_list_item_comments)
    end
  end

  describe '#destroy' do
    it 'deletes a previously stored list item' do
      item = ListItem.create(description: test_description, list: @list)
      expect(ListItem.exists?(item.id)).to be true
      item.destroy
      expect(ListItem.exists?(item.id)).to be false
    end
  end

  describe '#purchased?' do
    it 'detects when the requested quantity has been purchased' do
      item = ListItem.create(description: test_description, list: @list)
      expect(ListItem.exists?(item.id)).to be true
      item.quantity = 1
      item.purchased = 0
      expect(item.purchased?).to be false
      item.purchased = 1
      expect(item.purchased?).to be true
    end
  end
end
# rubocop:enable Metrics/BlockLength
