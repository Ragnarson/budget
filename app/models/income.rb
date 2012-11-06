class Income < ActiveRecord::Base
  attr_accessible :amount, :source, :tax
end
