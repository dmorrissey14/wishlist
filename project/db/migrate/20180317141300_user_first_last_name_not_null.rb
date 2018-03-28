# Makes the first_name and last_name columns not nullable.
class UserFirstLastNameNotNull < ActiveRecord::Migration[5.1]
  def up
    change_column_null :users, :first_name, false
    change_column_null :users, :last_name, false
  end

  def down
    change_column_null :users, :first_name, true
    change_column_null :users, :last_name, true
  end
end
