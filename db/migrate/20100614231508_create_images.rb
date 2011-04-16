class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|

      t.integer :hits, :default => 0, :null => false
      t.string :filename, :default => '', :null => false
      t.string :path, :default => '', :null => false
      t.integer :points, :default => 0, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
