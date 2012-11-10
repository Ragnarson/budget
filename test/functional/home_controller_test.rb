require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  def after
    DatabaseCleaner.clean
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_template :index
  end

  test 'should contain hello message and login link' do
    get :index
    assert_select 'h2', 'Welcome to the Budget Application'
    assert_select 'a', 'Login via Google account'
  end

  test 'should redirect to new_budget_path when authenticated' do
    sign_in users(:user1)
    Wallet.where(user_id: 1).delete_all
    get :index
    assert_redirected_to :new_budget
    assert_equal 'Successfully authenticated! Now please create your first budget.', flash[:notice]
  end

  test 'should be message with actual balance' do
    sign_in users(:user1)
    get :index
    assert_select 'ul.pull-right' do
      assert_select 'a', 'Actual balance: 0,00'
    end
  end

end
