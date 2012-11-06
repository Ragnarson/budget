class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.belongs_to :user
      t.string :name
      t.string :email
      t.datetime :sent_at
      t.boolean :received, :default=> false
      t.timestamps
    end
  end
end
