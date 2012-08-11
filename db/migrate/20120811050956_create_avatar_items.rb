class CreateAvatarItems < ActiveRecord::Migration
  def change
    create_table :avatar_items do |t|
      t.integer :avatar_id
      t.integer :item_id
      t.integer :quantity

      t.timestamps
    end
  end
end
