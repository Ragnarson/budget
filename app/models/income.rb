class Income < ActiveRecord::Base
  attr_accessible :source, :amount, :tax, :user_id

  belongs_to :user 
  
  validates :source, length: { in: 1..128 }
  validates :amount, numericality: { greater_than: 0}
  validates :tax, inclusion: { in: [18, 23] }, allow_nil: true
end
