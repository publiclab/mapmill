class AddMapExport < ActiveRecord::Migration
  def self.up
    add_column :sites, :map_export, :string, :default => ""
  end

  def self.down
    remove_column :sites, :map_export
  end
end
