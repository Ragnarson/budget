class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable,
    :rememberable, :trackable, :validatable, :omniauthable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :wallets
  has_many :incomes
  has_many :expenses, through: :wallets

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    User.where(:email => data["email"]).first_or_create(email: data["email"],
                                                        password: Devise.friendly_token[0,20])
  end

  def self.generate_password(length = 8)
    Devise.friendly_token.first(length)
  end

  def username
    login = self.email.split('@').first
    login.gsub(/[.\-_]/, ' ') unless login.blank?
  end

  def incomes_sum
    self.incomes.map(&:amount).inject(0, &:+)
  end

  def net_profits_sum
    self.incomes.map(&:net).inject(0, &:+)
  end

  def expenses_sum
    self.expenses.map(&:amount).inject(0, &:+)
  end
end
