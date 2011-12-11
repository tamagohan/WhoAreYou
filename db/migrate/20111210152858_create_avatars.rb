class CreateAvatars < ActiveRecord::Migration
  def self.up
    create_table :avatars do |t|
      t.integer :acount_id
      t.integer :avatar_tweet_id
      t.string :name
      t.datetime :birthday
      t.integer :sex

      t.timestamps
    end
  end

  def self.down
    drop_table :avatars
  end
end
