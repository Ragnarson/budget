namespace :db do
  desc "if execution_date.nil? then update to created_at"
  task populate: :environment do
    Expense.all(conditions: {execution_date: nil}).each do |ex|
      ex.execution_date = ex.created_at.to_date
      ex.save
    end
  end
end
