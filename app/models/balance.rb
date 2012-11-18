class Balance
  def  self.actual_balance(user_id)
    user = User.find(user_id)
    total_incomes = user.incomes_sum
    total_expenses = user.expenses_sum
    total_incomes-total_expenses
  end
end
