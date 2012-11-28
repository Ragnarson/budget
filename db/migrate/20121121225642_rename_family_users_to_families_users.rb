class RenameFamilyUsersToFamiliesUsers < ActiveRecord::Migration
  def change
    rename_table :family_users, :families_users
  end
end
