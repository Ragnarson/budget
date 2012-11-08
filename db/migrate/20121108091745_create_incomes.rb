class CreateIncomes < ActiveRecord::Migration
  def change
    create_table :incomes do |t|
      t.string :source, :null => false
      t.decimal :amount, precision: 8, scale: 2
      t.decimal :tax, precision: 2, scale: 0
      
      t.timestamps
    end
  end
end
