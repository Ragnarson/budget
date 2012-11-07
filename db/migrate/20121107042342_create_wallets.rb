class CreateWallets < ActiveRecord::Migration
  def change
    create_table :wallets do |t|
      t.belongs_to :user
      t.string :name
      t.decimal :amount, :precision => 10, :scale=> 2, :default => 0.00
      t.timestamps
    end
  end
end
