class ExpensesFix < ActiveRecord::Migration
  def change
    remove_column :expenses, :wallet_id, :integer
  end
end
