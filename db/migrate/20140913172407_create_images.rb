class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :url
      t.string :thumbnail
      t.string :status
      t.references :site, index: true

      t.timestamps
    end
  end
end
