class Balance
  attr_accessor :name, :amount, :date, :type, :done

  def initialize(name = "balance", amount, date, type, done)
    @name = name
    @amount = amount
    @date = date
    @type = type
    @done = done
  end

  def self.history(family, page, per_page)
    last_incomes = family.incomes.order('execution_date DESC').paginate(page: page, per_page: per_page)
    last_expenses = family.expenses.order('execution_date DESC').paginate(page: page, per_page: per_page)
    incomes_and_expenses_sorted_by_date = (last_incomes + last_expenses).sort {|operation1, operation2|( operation1.execution_date and operation2.execution_date ) ? operation2.execution_date <=> operation1.execution_date : ( operation1.execution_date ? -1 : 1 ) }
    operations = []
    last_execution_date = nil
    incomes_and_expenses_sorted_by_date.each do |income_or_expense|
      if operations.first.nil? || income_or_expense.execution_date != operations.last.date
        amount = family.balance_up_to(income_or_expense.execution_date)
        amount = family.balance_actual if !income_or_expense.execution_date && operations.first.nil?
        last_execution_date = income_or_expense.execution_date if income_or_expense.execution_date
        amount = family.balance_up_to(last_execution_date) if !income_or_expense.execution_date &&  last_execution_date

        operations << Balance.new(amount, income_or_expense.execution_date, :balance, nil)
      end
      if (income_or_expense.kind_of? Expense)
        operations << Balance.new(income_or_expense.name, income_or_expense.amount, income_or_expense.execution_date, :expense, income_or_expense.done)
      else
        operations << Balance.new(income_or_expense.source, income_or_expense.net, income_or_expense.execution_date, :income, nil)
      end
    end
    page ||= 1
    balances_as_page_results = WillPaginate::Collection.create(page, per_page, family.expenses.size+family.incomes.size) do |pager|
      pager.replace(operations)
    end
    balances_as_page_results
  end
end
