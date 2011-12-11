class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :login
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.integer :login_count
      t.datetime :current_login_at
      t.datetime :last_login_at
      t.integer :avatar_id
      t.integer :tweet_id

      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
