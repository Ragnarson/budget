class Expense < ActiveRecord::Base
  attr_accessible :name, :amount, :execution_date, :wallet_id, :family_id, :user_id

  belongs_to :wallet, inverse_of: :expenses
  belongs_to :family
  belongs_to :user

  validates :name, length: {in: 3..128}, presence: true
  validates :amount, presence: true,
            format: {with: /^\d+?(?:\.\d{0,2})?$/, message: I18n.t('errors.messages.invalid_price')},
            numericality: {greater_than: 0}
  validates :execution_date, presence: true,
            format: {with: /^(20\d\d)-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/, message: I18n.t('errors.messages.invalid_date')}
  validates :wallet, presence: true

  scope :not_categorized, conditions: {wallet_id: 0}
  scope :by_month, lambda { |family_id, date=Date.today| {
      conditions: ["expenses.execution_date between ? AND ? AND expenses.family_id=?",
                   date.to_date.at_beginning_of_month, date.to_date.at_end_of_month, family_id]} }

  def self.change_wallet(old_wallet_id, new_wallet_id = 0)
    update_all("wallet_id=#{new_wallet_id}", wallet_id: old_wallet_id)
  end

  def self.by_date(family_id, date)
    begin
      date = Date.parse(date)
    rescue
      date = Date.today
    end
    where(['expenses.execution_date between ? AND ? AND expenses.family_id=?',
           date.at_beginning_of_month, date.at_end_of_month, family_id]).order('expenses.execution_date DESC')
  end
end
