class RemoveListGroupId < ActiveRecord::Migration[5.1]
  def change
    change_table :lists do |t|
      t.remove :group_id
    end
  end
end
