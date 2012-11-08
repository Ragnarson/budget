class AddWalletIdToIncomes < ActiveRecord::Migration
  def change
    add_column :incomes, :wallet_id, :integer
  end
end
