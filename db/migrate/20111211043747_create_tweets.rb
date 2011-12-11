class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.integer :twitter_id
      t.integer :tw_id
      t.string :tw_str
      t.integer :tw_type
      t.string :tw_image_url
      t.datetime :tw_created_at

      t.timestamps
    end
  end

  def self.down
    drop_table :tweets
  end
end
