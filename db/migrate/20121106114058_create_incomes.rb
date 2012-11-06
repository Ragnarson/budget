class CreateIncomes < ActiveRecord::Migration
  def change
    create_table :incomes do |t|
      t.string :source
      t.decimal :amount
      t.decimal :tax

      t.timestamps
    end
  end
end
