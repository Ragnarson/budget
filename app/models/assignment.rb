class Assignment < ActiveRecord::Base
  belongs_to :wallet
  belongs_to :expense
end
