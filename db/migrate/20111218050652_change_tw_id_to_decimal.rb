class ChangeTwIdToDecimal < ActiveRecord::Migration
  def self.up
    change_column :tweets, :tw_id, :decimal, :precision => 20, :scale => 0
  end

  def self.down
    change_column :tweets, :tw_id, :integer
  end
end
