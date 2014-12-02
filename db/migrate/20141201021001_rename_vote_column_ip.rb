class RenameVoteColumnIp < ActiveRecord::Migration
  def change
    rename_column :votes, :ip, :cookie
  end
end
