class RemoveAndAddInviterToInvitations < ActiveRecord::Migration
  def change
    remove_column :invitations, :inviter_id
    add_column :invitations, :inviter_id, :integer
  end
end
