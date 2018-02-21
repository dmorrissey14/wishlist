# Creates the List_Items database table
class CreateListItems < ActiveRecord::Migration[5.1]
  def up
    create_table :list_items do |t|
      t.belongs_to :list, index: true, null: false, foreign_key: true
      t.string :description, limit: 100, null: false
      t.string :comments, limit: 300, null: true
      t.string :site_link, limit: 100, null: true
      t.integer :quantity, null: false, default: 1
      t.integer :purchased, null: false, default: 0
    end
  end

  def down
    drop_table :list_items
  end
end
