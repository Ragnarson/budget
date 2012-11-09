class Expense < ActiveRecord::Base
  attr_accessible :name, :amount
  
  belongs_to :wallet

  validates :name, length: { in: 3..128 }
  validates :amount,
    format: { with: /^\d+??(?:\.\d{0,2})?$/, message: 'must be valid price' }, 
    numericality: { :greater_than => 0 }
end
