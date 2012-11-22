class Balance
  def  self.actual(user)
    total_incomes = user.net_profits_sum
    total_expenses = user.expenses_sum
    total_incomes-total_expenses
  end
end
