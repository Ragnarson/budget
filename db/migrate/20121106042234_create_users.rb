class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      ########## add extra fields needed by devise/omniauth/etc
      t.string :auth_token, :default=> ''
      t.string :picture
      t.string :url_token
      t.string :ip,
      t.timestamps
    end
    #add_index :users, :email, :name => 'users_idx1'
  end
end
