class AddFamilyIdToIncomes < ActiveRecord::Migration
  def change
    add_column :incomes, :family_id, :integer
  end
end
