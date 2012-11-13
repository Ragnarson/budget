class AddExecutionDateToExpense < ActiveRecord::Migration
  def change
    add_column :expenses, :execution_date, :date
  end
end
