class AddImageUrlToAvatars < ActiveRecord::Migration
  def self.up
    add_column :avatars, :image_url, :text
  end

  def self.down
    remove_column :avatars, :image_url
  end
end
