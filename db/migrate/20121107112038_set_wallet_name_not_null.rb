class SetWalletNameNotNull < ActiveRecord::Migration
  def up
    change_column :wallets, :name, :string, null: false
  end

  def down
    change_column :wallets, :name, :string, null: true
  end
end
