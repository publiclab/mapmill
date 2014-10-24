class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :image, index: true
      t.integer :value

      t.timestamps
    end
  end
end
