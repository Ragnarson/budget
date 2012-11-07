class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.string :name, :null => false
      t.decimal :amount, precision: 10, scale: 2, default: 0.00

      t.timestamps
    end
  end
end
