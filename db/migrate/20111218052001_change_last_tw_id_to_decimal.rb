class ChangeLastTwIdToDecimal < ActiveRecord::Migration
  def self.up
    change_column :twitters, :last_tw_id, :decimal, :precision => 20, :scale => 0
  end

  def self.down
    change_column :twitters, :last_tw_id, :integer
  end
end
