class AddFamilyFieldToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :family_id, :integer
    add_column :expenses, :user_id, :integer
    add_index :expenses, :family_id
    add_index :expenses, :user_id

    Expense.all.each do |expense|
      expense.update_attributes({family_id: expense.wallet.family_id, user_id: expense.wallet.user_id}) if expense.wallet_id.to_i > 0
    end
  end
end
