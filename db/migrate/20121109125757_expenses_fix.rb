class ExpensesFix < ActiveRecord::Migration
  def change
    remove_column :expenses, :wallet_id
  end
end
