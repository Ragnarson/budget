class Expense < ActiveRecord::Base
  attr_accessible :name, :amount, :execution_date, :wallet_id
  
  belongs_to :wallet

  validates :name, length: { in: 3..128 }, presence: true
  validates :amount, presence: true,
    format: { with: /^\d+??(?:\.\d{0,2})?$/, message: 'must be valid price' }, 
    numericality: { :greater_than => 0 }
  validates :execution_date, presence: true,
    format: { with: /^(20\d\d)-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/, message: 'must be valid date' }
  validates :wallet_id, presence: true, numericality: { only_integer: true }
end
