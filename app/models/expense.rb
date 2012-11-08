class Expense < ActiveRecord::Base
  attr_accessible :name, :amount
  
  has_many :assignments
  has_many :wallets, through: :assignments

  validates :name, :presence => true, :length => { in: 3..128 }
  validates :amount, :presence => true, 
    :format => { :with => /^\d+??(?:\.\d{0,2})?$/, :message => 'must be valid price' }, 
    :numericality => { :greater_than => 0, :decimal => true}
end
