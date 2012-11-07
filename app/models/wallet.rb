class Wallet < ActiveRecord::Base
  attr_accessible :name, :amount

  validates_presence_of :name

end
