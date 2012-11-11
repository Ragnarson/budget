class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :wallets

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first_or_create(email: data["email"],
                                                               password: Devise.friendly_token[0,20])

    user
  end

  def self.generate_password(length = 8)
    rand(36**length).to_s(36)
  end
end

