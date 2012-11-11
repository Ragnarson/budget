class AddInvitedByToUsers < ActiveRecord::Migration
  def change
    add_column :users, :invited_by, :integer
  end
end
