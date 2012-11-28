class AddFamilyIdToWallets < ActiveRecord::Migration
  def change
    add_column :wallets, :family_id, :integer
  end
end
