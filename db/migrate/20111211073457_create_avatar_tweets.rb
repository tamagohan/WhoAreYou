class CreateAvatarTweets < ActiveRecord::Migration
  def self.up
    create_table :avatar_tweets do |t|
      t.integer :avatar_twitter_id
      t.integer :tw_av_id
      t.string :tw_av_str
      t.integer :tw_av_type
      t.string :tw_av_image_url

      t.timestamps
    end
  end

  def self.down
    drop_table :avatar_tweets
  end
end
