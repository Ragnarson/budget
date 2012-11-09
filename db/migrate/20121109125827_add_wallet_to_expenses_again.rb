class AddWalletToExpensesAgain < ActiveRecord::Migration
  def change
    add_column :expenses, :wallet_id, :integer
  end
end
