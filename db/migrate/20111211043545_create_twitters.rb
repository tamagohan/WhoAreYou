class CreateTwitters < ActiveRecord::Migration
  def self.up
    create_table :twitters do |t|
      t.integer :account_id
      t.integer :tweet_id
      t.string :oauth_token
      t.string :oauth_verifier
      t.integer :last_tw_id, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :twitters
  end
end
