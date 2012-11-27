class WalletsUserIdCanBeNull < ActiveRecord::Migration
  def change
    change_column :wallets, :user_id, :integer, :null => true
  end
end
