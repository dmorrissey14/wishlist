# Creates the Groups database table
class CreateGroups < ActiveRecord::Migration[5.1]
  def up
    create_table :groups do |t|
      t.string :name, limit: 100, null: false
      t.string :description, limit: 300, null: true
    end
  end

  def down
    drop_table :groups
  end
end
