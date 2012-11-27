class CreateFamilyUsersTable < ActiveRecord::Migration
  def change
    create_table :family_users, :id => false do |t|
      t.column :family_id, :integer
      t.column :user_id, :integer
    end
  end
end
