class Wallet < ActiveRecord::Base
  attr_accessible :name, :amount
  
  has_many :expenses

  validates_presence_of :name

end
