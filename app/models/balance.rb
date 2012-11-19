class Balance
  def  self.actual(user)
    total_incomes = user.incomes_sum
    total_expenses = user.expenses_sum
    total_incomes-total_expenses
  end
end
