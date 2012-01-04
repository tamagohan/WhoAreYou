class AddEmotionToTweets < ActiveRecord::Migration
  def self.up
    add_column :tweets, :emotion, :decimal, :precision => 11, :scale => 8, :default => 0.0, :null => false
  end

  def self.down
    remove_column :tweets, :emotion
  end
end
