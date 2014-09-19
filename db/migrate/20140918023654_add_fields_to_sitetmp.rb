class AddFieldsToSitetmp < ActiveRecord::Migration
  def change
    add_column :sitetmps, :name, :string
    add_column :sitetmps, :date, :date
    add_column :sitetmps, :description, :text
  end
end
