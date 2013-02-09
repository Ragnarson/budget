class MarkExpenseAsDone < ActiveRecord::Migration
  def up
    add_column :expenses, :done, :boolean, default: 1

    Expense.all.each do |e|
      if e.execution_date.future?
        e.done = 0
        e.save
      end
    end
  end

  def down
    remove_column :expenses, :done
  end
end
