# Creates the join table (HABTM) for groups able to view lists
class CreateGroupsLists < ActiveRecord::Migration[5.1]
  def up
    create_join_table :groups, :lists do |t|
      t.references :group, index: true, null: false, foreign_key: true
      t.references :list, index: true, null: false, foreign_key: true
      t.index %i[group_id list_id]
      t.index %i[list_id group_id]
    end
  end

  def down
    drop_join_table :groups, :lists
  end
end
