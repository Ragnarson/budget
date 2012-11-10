require 'test_helper'

class WalletsControllerTest < ActionController::TestCase
  def setup
    sign_in users(:user1)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:wallet)
  end

  test "should be form on page" do

    get :new
    assert_select 'form' do
      assert_select 'input#wallet_name'
      assert_select 'input#wallet_amount'
      assert_select 'input[TYPE=submit]'
    end
  end

  test "should create budget and redirect to new with notice" do
    post :create, :wallet => {:name => 'Some title'}
    wallet = Wallet.new(@request.params[:wallet])
    assert_redirected_to :new_budget
    assert_equal "Your new '#{wallet.name}' budget was added successfully", flash[:notice]
  end

  test "should show error when name is empty" do
    post :create, :wallet => {:name => ''}
    assert_tag :tag => 'span', :content => "can't be blank"
    assert_template :new
  end

  test "on form page should be placeholder for income list" do
    get :new
    assert_tag :tag => 'div', :attributes => { :id => 'budget_amount_wrapper' }
  end

  test "on form page should be placed link to plan budget" do
    get :new
    assert_tag :tag => 'a', :attributes => { :id => 'budget_plan'}
  end

end
