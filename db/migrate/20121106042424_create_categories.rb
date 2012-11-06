class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.belongs_to :user
      #t.belongs_to :income #it depends if we are planning to divide expenses for each income
      t.string :name
      t.decimal :amount, :precision => 10, :scale=> 2, :default => 0.00
      t.decimal :tax, :precision => 4, :scale=> 2, :default => 0.00
      t.timestamps
    end
    add_index :categories, :user_id, :name => 'incomes_idx1'
  end
end
