class Wallet < ActiveRecord::Base
  attr_accessible :name, :amount, :expenses_attributes
  before_create :initialize_amount

  has_many :expenses, inverse_of: :wallet, dependent: :destroy
  belongs_to :family

  accepts_nested_attributes_for :expenses, allow_destroy: true

  validates_presence_of :name, :family_id
  validates :amount, numericality: { decimal: true }, allow_blank: true

  def expenses_number
    expenses.size
  end

  def destroy_without_expenses
    Expense.change_wallet(self.id)
    destroy
  end

  def remaining_amount
    self.amount - get_expenses_amount_sum
  end

  private
  def initialize_amount
    sum = get_expenses_amount_sum
    self.amount = sum if sum > 0
  end

  def get_expenses_amount_sum
    self.expenses.map(&:amount).sum
  end
end
