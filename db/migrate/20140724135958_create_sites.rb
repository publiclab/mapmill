class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.date :date
      t.text :description
      t.float :lat
      t.float :lon
      t.date :updated

      t.timestamps
    end
  end
end
