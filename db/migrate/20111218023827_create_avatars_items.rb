class CreateAvatarsItems < ActiveRecord::Migration
  def self.up
    create_table(:avatars_items, :id => false) do |table|
      table.column(:avatar_id, :integer)
      table.column(:item_id, :integer)
    end
  end

  def self.down
    drop_table(:avatars_items)
  end
end
