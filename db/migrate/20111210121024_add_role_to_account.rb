class AddRoleToAccount < ActiveRecord::Migration
  def self.up
    add_column :accounts, :role, :integer
  end

  def self.down
    remove_column :accounts, :role
  end
end
