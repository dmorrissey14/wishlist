class ModifyUsers < ActiveRecord::Migration[5.1]
  def up
    change_column :users, :email_hash, :string, :limit => 60, null: false
    change_column :users, :password_hash, :string, :limit => 60, null: false
    change_column :users, :session_token_hash, :string, :limit => 60
  end

  def down
    change_column :users, :email_hash, :string, :limit => 32
    change_column :users, :password_hash, :string, :limit => 32
    change_column :users, :session_token_hash, :string, :limit => 32
  end
end
