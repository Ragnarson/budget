class AddExecutionDateToIncome < ActiveRecord::Migration
  def change
    add_column :incomes, :execution_date, :date
  end
end
