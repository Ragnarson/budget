class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :wallet_id
      t.integer :expense_id
    end
    add_index :assignments, :wallet_id
    add_index :assignments, :expense_id
  end
end
