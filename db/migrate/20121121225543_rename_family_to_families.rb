class RenameFamilyToFamilies < ActiveRecord::Migration
  def change
    rename_table :family, :families
  end
end
