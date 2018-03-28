# Removes the Group foreign key from the Lists table.
class RemoveListGroupId < ActiveRecord::Migration[5.1]
  def up
    change_table :lists do |t|
      t.remove :group_id
    end
  end

  def down
    change_table :lists do |t|
      t.belongs_to :group, null: false, foreign_key: true
    end
  end
end
