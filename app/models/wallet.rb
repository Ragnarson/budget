class Wallet < ActiveRecord::Base
  attr_accessible :name, :amount, :user_id
  
  has_many :expenses
  belongs_to :user

  validates_presence_of :name
  validates :amount, :numericality => {:decimal => true}, :allow_blank=> true
end
