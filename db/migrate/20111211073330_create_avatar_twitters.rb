class CreateAvatarTwitters < ActiveRecord::Migration
  def self.up
    create_table :avatar_twitters do |t|
      t.integer :avatar_id
      t.string :auth_id
      t.string :auth_password
      t.string :twitter_name
      t.integer :last_cp_tw_id, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :avatar_twitters
  end
end
