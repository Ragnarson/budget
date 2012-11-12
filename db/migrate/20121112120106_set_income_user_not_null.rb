class SetIncomeUserNotNull < ActiveRecord::Migration
  def change
    change_column :incomes, :user_id, :integer, null: false
  end
end
