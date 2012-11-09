class AddWalletIdToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :wallet_id, :integer
  end
end
