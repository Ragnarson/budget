class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.belongs_to :user
      t.belongs_to :category
      t.string :name
      t.string :place
      t.decimal :amount, :precision => 10, :scale=> 2, :default => 0.00
      t.timestamps
    end
    add_index :expenses, :user_id, :name => 'expenses_idx1'
  end
end
