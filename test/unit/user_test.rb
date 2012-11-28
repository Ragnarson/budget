require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users

  def setup
    @user = users(:user_with_wallet_1)
  end

  test "should create some username from email" do
    assert_equal @user.username, 'user with wallet 1'
  end
end
