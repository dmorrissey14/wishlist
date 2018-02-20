# Creates the Lists database table
class CreateLists < ActiveRecord::Migration[5.1]
  def up
    create_table :lists do |t|
      t.belongs_to :user, index: true, null: false, foreign_key: true
      t.belongs_to :group, null: false, foreign_key: true
      t.string :name, limit: 100, null: false
      t.string :description, limit: 300, null: true
    end
  end

  def down
    drop_table :lists
  end
end
