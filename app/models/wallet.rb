class Wallet < ActiveRecord::Base
  attr_accessible :name, :amount
  
  has_many :expenses

  belongs_to :user

  validates_presence_of :name

end
