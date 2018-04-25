# Adds the image_link field to the ListItem database table.
class AddImageLinkToListItems < ActiveRecord::Migration[5.1]
  def up
    add_column :list_items, :image_link, :string, limit: 100, null: true
  end

  def down
    remove_column :list_items, :image_link, :string
  end
end
