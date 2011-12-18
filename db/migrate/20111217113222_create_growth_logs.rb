class CreateGrowthLogs < ActiveRecord::Migration
  def self.up
    create_table :growth_logs do |t|
      t.integer :avatar_id
      t.integer :growth_type
      t.boolean :is_informed, :null => false, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :growth_logs
  end
end
