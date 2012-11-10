require 'test_helper'

class WalletTest < ActiveSupport::TestCase
  def setup
    @wallet = Wallet.new
  end

  test "should recognize empty inputs" do
    assert_equal @wallet.valid?, false
  end

  test "should recognize empty name" do
    @wallet.amount = 100
    assert_equal @wallet.valid?, false
  end

  test "should recognize invalid amount" do
    @wallet.attributes = {name: 'some_name', amount: 'nothing'}
    assert_equal @wallet.valid?, false
  end

end
