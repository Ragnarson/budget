class Income < ActiveRecord::Base
  attr_accessible :source, :amount, :tax, :user_id

  belongs_to :user 
  
  validates :source, length: { in: 1..128 }
  validates :amount, numericality: { greater_than: 0}
  validates :tax, numericality: { greater_than_or_equal_to: 0, less_than: 100 }

  def net
    (amount/(1+(tax.to_f/100))).round(2)
  end
end
