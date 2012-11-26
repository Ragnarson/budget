class Income < ActiveRecord::Base
  attr_accessible :source, :amount, :tax, :user_id, :execution_date

  belongs_to :user 
  
  validates :source, length: { in: 1..128 }
  validates :amount, numericality: { greater_than: 0}
  validates :tax, numericality: { greater_than_or_equal_to: 0, less_than: 100 }
  validates :execution_date, presence: true,
            format: {with: /^(20\d\d)-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/, message: I18n.t('errors.messages.invalid_date')}

  def net
    (amount/(1+(tax.to_f/100))).round(2)
  end
end
