class Family < ActiveRecord::Base
  has_many :wallets
  has_many :incomes
  has_many :expenses, through: :wallets
  has_and_belongs_to_many :users

  def net_profits_sum
    self.incomes.map(&:net).inject(0, &:+)
  end

  def incomes_sum
    self.incomes.map(&:amount).inject(0, &:+)
  end

  def expenses_sum
    self.expenses.map(&:amount).inject(0, &:+)
  end

  def net_profits_sum_up_to(date)
    incomes_with_date = incomes.where("execution_date <= ?", date).map(&:net).inject(0, &:+)
    incomes_without_date =  incomes.where(:execution_date => nil).map(&:net).inject(0, &:+)
    incomes_with_date+incomes_without_date
  end

  def expenses_sum_up_to(date)
    self.expenses.where("execution_date <= ?", date).map(&:amount).inject(0, &:+)
  end

  def balance_actual
    self.net_profits_sum - self.expenses_sum
  end

  def balance_up_to(date)
    self.net_profits_sum_up_to(date) - self.expenses_sum_up_to(date)
  end

  def expenses_by_date(date)
    date = Date.today if date.blank?
    self.expenses.where(['execution_date between ? AND ?', date.at_beginning_of_month, date.at_end_of_month]).order('execution_date DESC')
  end
end
