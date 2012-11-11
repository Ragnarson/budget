class Expense < ActiveRecord::Base
  attr_accessible :name, :amount, :wallet_id
  
  belongs_to :wallet

  validates :name, length: { in: 3..128 }, presence: true
  validates :amount, presence: true,
    format: { with: /^\d+??(?:\.\d{0,2})?$/, message: 'must be valid price' }, 
    numericality: { :greater_than => 0 }
  validates :wallet_id, presence: true, numericality: { only_integer: true }
end
