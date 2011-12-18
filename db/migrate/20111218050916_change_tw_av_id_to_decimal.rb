class ChangeTwAvIdToDecimal < ActiveRecord::Migration
  def self.up
    change_column :avatar_tweets, :tw_av_id, :decimal, :precision => 20, :scale => 0
  end

  def self.down
    change_column :avatar_tweets, :tw_av_id, :integer,
  end
end
