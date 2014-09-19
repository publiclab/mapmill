class CreateSitetmp < ActiveRecord::Migration
  def change
    create_table :sitetmps do |t|
      t.string :nonce
    end
  end
end
