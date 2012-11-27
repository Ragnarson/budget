class IncomesUserIdCanBeNull < ActiveRecord::Migration
  def change
    change_column :incomes, :user_id, :integer, :null => true
  end
end
