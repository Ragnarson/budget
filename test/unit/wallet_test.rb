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
    @wallet.attributes = { name: 'some_name', amount: 'nothing' }
    assert_equal @wallet.valid?, false
  end

  test "should save valid wallet with expense" do
    assert_equal Wallet.new(name: 'some_name', amount: '10', expenses_attributes: { 0=> { name: 'food', amount: 9, execution_date: '2012-11-12' } }).save, true
  end

  test "should recognize invalid amount in expense" do
    assert_equal Wallet.new(name: 'some_name', amount: '10', expenses_attributes: { 0=> { name: 'food', amount: 'ble', execution_date: '2012-11-12' } }).save, false
  end

end
