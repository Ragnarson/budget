class Balance
  attr_accessor :name, :amount, :date, :type

  def initialize(name = "balance", amount, date, type)
    @name = name
    @amount = amount
    @date = date
    @type = type
  end

  def self.actual(user)
    incomes_sum = user.net_profits_sum
    expenses_sum = user.expenses_sum
    incomes_sum-expenses_sum
  end

  def self.up_to(user, date)
    incomes_sum_up_to_date = user.net_profits_sum_up_to(date)
    expenses_sum_up_to_date = user.expenses_sum_up_to(date)
    incomes_sum_up_to_date - expenses_sum_up_to_date
  end

  def self.history(user, page, per_page)
    last_incomes = user.incomes.order('execution_date DESC').paginate(page: page, per_page: per_page)
    last_expenses = user.expenses.order('execution_date DESC').paginate(page: page, per_page: per_page)
    incomes_and_expenses_sorted_by_date = (last_incomes + last_expenses).sort {|income, expense|( income.execution_date and expense.execution_date ) ? expense.execution_date <=> income.execution_date : ( income.execution_date ? -1 : 1 ) }
    operations = []
    last_execution_date = nil
    incomes_and_expenses_sorted_by_date.each do |income_or_expense|
      if operations.first.nil? || income_or_expense.execution_date != operations.last.date
        amount = up_to(user, income_or_expense.execution_date)
        amount = actual(user) if !income_or_expense.execution_date && operations.first.nil?
        last_execution_date = income_or_expense.execution_date if income_or_expense.execution_date
        amount = up_to(user, last_execution_date) if !income_or_expense.execution_date &&  last_execution_date

        operations << Balance.new(amount, income_or_expense.execution_date, :balance)
      end
      if (income_or_expense.kind_of? Expense)
        operations << Balance.new(income_or_expense.name, income_or_expense.amount, income_or_expense.execution_date, :expense)
      else
        operations << Balance.new(income_or_expense.source, income_or_expense.net, income_or_expense.execution_date, :income)
      end
    end
    page ||= 1
    balances_as_page_results = WillPaginate::Collection.create(page, per_page, user.expenses.size+user.incomes.size) do |pager|
      pager.replace(operations)
    end
    return balances_as_page_results
  end
end
