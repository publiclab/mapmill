class AddIdentityUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :identity_url, :string
  end
end
