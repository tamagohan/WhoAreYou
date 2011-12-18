class ChangeLastCpTwIdToDecimal < ActiveRecord::Migration
  def self.up
    change_column :avatar_twitters, :last_cp_tw_id, :decimal, :precision => 20, :scale => 0
  end

  def self.down
    change_column :avatar_twitters, :last_cp_tw_id, :integer
  end
end
