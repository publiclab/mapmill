class ChangeImageQuality < ActiveRecord::Migration
  def change
    change_column :images, :quality, :decimal, default: 0.0
  end
end
