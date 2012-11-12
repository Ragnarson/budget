class SetIncomeUserNotNull < ActiveRecord::Migration
  def change
    change_table :incomes, :user_id, :integer, null: false
  end
end
