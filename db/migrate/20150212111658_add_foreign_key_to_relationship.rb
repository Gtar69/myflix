class AddForeignKeyToRelationship < ActiveRecord::Migration
  def change
    rename_column :relationships, :follower_id, :test_id
    rename_column :relationships, :test_id, :follower_id
  end
end
