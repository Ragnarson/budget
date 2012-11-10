require 'test_helper'

class IncomesControllerTest < ActionController::TestCase
  def after
    DatabaseCleaner.clean
  end

  test "should generate proper form on new income page" do
    get :new
    assert_select 'form' do
      assert_select 'input#income_source'
      assert_select 'input#income_amount'
      assert_select 'input[TYPE=submit]'
    end
  end
  
  test "should render new if income amount is not valid" do
    post :create, :income => { :source => 'source', :amount => 'zero' }
    assert_template 'new'
  end

  test "should redirect to new income and notify about creation if source and amount are valid" do
    post:create, :income => { :source => 'source', :amount => 200 }
    assert_redirected_to new_income_path
    assert_equal 'Income has been successfully created', flash[:notice]
  end
end
