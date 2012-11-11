class Income < ActiveRecord::Base
  attr_accessible :source, :amount, :tax

  validates :source, length: { in: 1..128 }
  validates :amount, numericality: { greater_than: 0}
  validates :tax, inclusion: { in: [18, 23, nil] }
end
