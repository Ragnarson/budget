class CreateIncomes < ActiveRecord::Migration
  def change
    create_table :incomes do |t|
      t.belongs_to :user
      t.string :name
      t.decimal :amount, :precision => 10, :scale=> 2, :default => 0.00
      t.boolean :monthly_renew, :default=> true #user can add monthly incomes from work/other contract/and also can add occasional incomes
      t.timestamps
    end
    add_index :incomes, :user_id, :name => 'incomes_idx1'
  end
end
