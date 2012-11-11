class Income < ActiveRecord::Base
  attr_accessible :source, :amount, :tax

  validates :source, presence: true, length: { in: 1..128 }
  validates :amount, presence: true, 
      numericality: { greater_than: 0}
  validates :tax, inclusion: { in: [18, 23, nil] }
end
