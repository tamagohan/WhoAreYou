class CreateEmotionalWords < ActiveRecord::Migration
  def self.up
    create_table :emotional_words do |t|
      t.string :word
      t.string :reading
      t.integer :pos
      t.decimal :semantic_orientation, :precision => 10, :scale => 8, :default => 0.0, :null => false

      t.timestamps
    end
    add_index :emotional_words, :word
  end

  def self.down
    remove_index :emotional_words, :word
    drop_table :emotional_words
  end
end
