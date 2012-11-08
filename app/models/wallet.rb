class Wallet < ActiveRecord::Base
  attr_accessible :name, :amount
  
  has_many :assignments
  has_many :expenses, through: :assignments

  validates_presence_of :name

end
