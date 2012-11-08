class AddWalletIdToExpenses < ActiveRecord::Migration
  add_column :expenses, :wallet_id, :integer
end
