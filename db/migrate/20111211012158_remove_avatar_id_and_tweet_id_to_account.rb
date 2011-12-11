class RemoveAvatarIdAndTweetIdToAccount < ActiveRecord::Migration
  def self.up
    remove_column :accounts, :avatar_id
    remove_column :accounts, :tweet_id
  end

  def self.down
    add_column :accounts, :avatar_id, :integer
    add_column :accounts, :tweet_id, :integer
  end
end
