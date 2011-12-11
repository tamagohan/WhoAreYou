class RenameAcountIdToAccountIdInAvatar < ActiveRecord::Migration
  def self.up
    rename_column :avatars, :acount_id, :account_id
  end

  def self.down
    rename_column :avatars, :account_id, :acount_id
  end
end
