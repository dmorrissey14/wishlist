# Creates the Users database table
class CreateUsers < ActiveRecord::Migration[5.1]
  def up
    create_table :users do |t|
      t.string :email_hash, limit: 32, null: false
      t.string :password_hash, limit: 32, null: false
      t.string :first_name, limit: 32, null: true
      t.string :last_name, limit: 32, null: true
    end
  end

  def down
    drop_table :users
  end
end
