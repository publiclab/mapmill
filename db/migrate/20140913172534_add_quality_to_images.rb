class AddQualityToImages < ActiveRecord::Migration
  def change
    add_column :images, :quality, :integer, default: 0
  end
end
