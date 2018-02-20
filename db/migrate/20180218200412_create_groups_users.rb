# Creates the join table (HABTM) for group membership of users
class CreateGroupsUsers < ActiveRecord::Migration[5.1]
  def up
    create_join_table :groups, :users do |t|
      t.references :group, index: true, null: false, foreign_key: true
      t.references :user, index: true, null: false, foreign_key: true
      t.index %i[group_id user_id]
      t.index %i[user_id group_id]
    end
  end

  def down
    drop_join_table :groups, :users
  end
end
