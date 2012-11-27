class CreateFamilyTable < ActiveRecord::Migration
  def change
    create_table :family do |t|
      t.datetime :created_at
    end
  end
end
