class Income < ActiveRecord::Base
  attr_accessible :source, :amount, :tax, :user_id

  belongs_to :user 
  
  validates :source, length: { in: 1..128 }
  validates :amount, numericality: { greater_than: 0}
  validates :tax, numericality: { in: 0..99 }, allow_nil: true

  def net
    tax_rate = "0." + tax.to_s
    amount * (1 - tax_rate.to_f)
  end
end
