class AlterColumnName < ActiveRecord::Migration[5.1]
  def up
    rename_column :users, :remember_digest, :session_token_hash
  end

  def down
    rename_column :users, :session_token_hash, :remember_digest
  end
end
