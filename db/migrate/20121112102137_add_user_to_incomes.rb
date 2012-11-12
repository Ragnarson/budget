class AddUserToIncomes < ActiveRecord::Migration
  def change
    add_column :incomes, :user_id, :integer
  end
end
