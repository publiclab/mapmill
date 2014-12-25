class AddLatLongToImages < ActiveRecord::Migration
  def change
    add_column :images, :lat, :decimal, {:precision=>10, :scale=>6}
    add_column :images, :lng, :decimal, {:precision=>10, :scale=>6}
  end
end
